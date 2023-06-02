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
(1,1,GETDATE()),
(2,2,GETDATE()),
(1,3,GETDATE()),
(2,4,GETDATE())

GO

CREATE OR ALTER PROC fila.tbFilasPosiciones
(@fiat_ID INT,
 @ticl_ID INT,)
 AS
 BEGIN
	BEGIN TRY 
	END TRY
	BEGIN CATCH
	END CATCH
 END


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


CREATE OR ALTER PROC fila.UDP_tbFilasAtraccion_SELECT
@tifi_ID	INT,
@atra_ID	INT
AS
BEGIN
DECLARE @fiat_ID INT = (
SELECT fiat_ID FROM  fila.VW_tbFilasAtraccion WHERE tifi_ID = @tifi_ID AND atra_ID = @atra_ID)

END