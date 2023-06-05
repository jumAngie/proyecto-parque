USE dbParqueAtracciones
GO
INSERT INTO fila.tbTipoFilas
(tifi_Nombre,tifi_UsuarioCreador)
VALUES
('CLASICA',1),
('VIP',1)

GO

INSERT INTO fila.tbFilasAtraccion
(tifi_ID,atra_ID,fiat_UsuarioCreador)
VALUES
(1,1,1),
(2,1,1),
(1,2,1),
(2,2,1),
(1,3,1),
(2,3,1),
(1,4,1),
(2,4,1)



GO

INSERT INTO fila.tbFilasPosiciones
(fiat_ID,ticl_ID,fipo_HoraIngreso)
VALUES
(2,5,GETDATE()),
(2,6,GETDATE()),
(1,1,GETDATE()),
(2,2,GETDATE()),
(1,3,GETDATE())





GO
CREATE OR ALTER VIEW fila.VW_tbFilasAtraccion
AS 
SELECT	fiat_ID,
		T1.tifi_ID,
		T2.tifi_Nombre,
		T1.atra_ID,
		T3.atra_Nombre
FROM fila.tbFilasAtraccion	T1
INNER JOIN fila.tbTipoFilas T2
ON T1.tifi_ID = T2.tifi_ID
INNER JOIN parq.tbAtracciones T3
ON T1.atra_ID = T3.atra_ID

GO


CREATE OR ALTER VIEW fila.VW_tbFilasPosiciones
AS
SELECT 
    fipo_ID,
    fiat_ID,
    ticl_ID,
    CASE 
        WHEN (SELECT clie_NombreCompleto FROM parq.VW_tbClientes WHERE clie_ID = (SELECT clie_ID FROM parq.tbTicketsCliente WHERE ticl_ID = T1.ticl_ID)) IS NOT NULL THEN 
            (SELECT clie_NombreCompleto FROM parq.VW_tbClientes WHERE clie_ID = (SELECT clie_ID FROM parq.tbTicketsCliente WHERE ticl_ID = T1.ticl_ID))
        ELSE 
            COALESCE((SELECT clie_NombreCompleto FROM parq.VW_tbClientesRegistrados WHERE clre_ID = (SELECT clre_ID FROM parq.tbTicketsCliente WHERE ticl_ID = T1.ticl_ID)), 'N/A')
    END AS Cliente_Nombre,
    CONVERT(NVARCHAR(30), fipo_HoraIngreso, 100) AS fipo_HoraIngreso
FROM fila.tbFilasPosiciones T1



GO

CREATE OR ALTER PROC fila.UDP_tbFilasPosiciones_SELECT 
@tifi_ID	INT,
@atra_ID	INT
AS
BEGIN
	DECLARE @fiat_ID INT = (
	SELECT fiat_ID FROM  fila.VW_tbFilasAtraccion WHERE tifi_ID = @tifi_ID AND atra_ID = @atra_ID)

	SELECT  ROW_NUMBER() OVER (ORDER BY fipo_ID) AS posicion,
	*
	FROM fila.VW_tbFilasPosiciones 
	WHERE fiat_ID = @fiat_ID
	
END

GO

CREATE OR ALTER PROC fila.tbFilasPosiciones_INSERT
(
	@atra_ID INT,
	@ticl_ID NVARCHAR(MAX)
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION; 

		IF EXISTS (SELECT * FROM fila.tbFilasPosiciones WHERE ticl_ID = @ticl_ID)
		BEGIN
			DECLARE @fiat INT = (SELECT fiat_ID FROM fila.tbFilasPosiciones WHERE ticl_ID = @ticl_ID)
			DECLARE @atra INT = (SELECT atra_ID FROM fila.tbFilasAtraccion WHERE fiat_ID = @fiat)
			DECLARE @atraccion NVARCHAR(MAX) = (SELECT atra_Nombre FROM parq.tbAtracciones WHERE atra_ID = @atra);
			SELECT 409 AS codeStatus, 'Actualmente este Ticket ya ha sido registrado en una fila de la atracción: ' + @atraccion AS messageStatus;
		END
		ELSE
		BEGIN
			DECLARE @tifi_ID INT = (SELECT tckt_ID FROM parq.tbTicketsCliente WHERE ticl_ID = @ticl_ID);

			DECLARE @fiat_ID INT = (SELECT fiat_ID FROM fila.tbFilasAtraccion  WHERE tifi_ID = @tifi_ID AND atra_ID = @atra_ID);

			INSERT INTO fila.tbFilasPosiciones (fiat_ID, ticl_ID, fipo_HoraIngreso)
			VALUES (@fiat_ID, @ticl_ID, GETDATE());

			SELECT 200 AS codeStatus, 'Posición Insertada con éxito' AS messageStatus;
		END

		COMMIT TRANSACTION; 
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION; 

		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus;
	END CATCH;
END

GO

CREATE OR ALTER PROC fila.tbFilasPosiciones_DELETE_COMPLETO 
@atra_ID INT,
@fiat_ID INT
AS
BEGIN
    DECLARE @top INT = (SELECT atra_LimitePersonas FROM parq.tbAtracciones WHERE atra_ID = @atra_ID);

    DELETE FROM fila.tbFilasPosiciones
    WHERE fiat_ID IN (
        SELECT TOP (10) fipo_ID
        FROM fila.tbFilasPosiciones
		WHERE fiat_ID = @fiat_ID
		ORDER BY fipo_ID
    );

		SELECT 200 AS codeStatus, 'Posiciones de Fila Actualizada' AS messageStatus;
END

GO

CREATE OR ALTER PROC fila.tbFilasPosiciones_DELETE
@fipo_ID INT
AS
BEGIN
    BEGIN TRY
		
		DELETE FROM fila.tbFilasPosiciones
		WHERE fipo_ID = @fipo_ID 

		SELECT 200 AS codeStatus, 'Posiciones de Fila Actualizada' AS messageStatus;

	END TRY
	BEGIN CATCH

		SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

	END CATCH
END
