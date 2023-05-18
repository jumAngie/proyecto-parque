USE dbParqueAtracciones

---------------------------------------------------------------- ESQUEMA PARQ ----------------------------------------------------------------
------------------------------------------------------- //// PROCS PARA tbCargos -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE CARGO ******************--

GO
CREATE OR ALTER VIEW parq.VW_tbCargos
AS
SELECT [carg_ID]
      ,[carg_Nombre]
      ,[carg_Habilitado]
      ,[carg_Estado]
      ,[carg_UsuarioCreador]
      ,[carg_FechaCreacion]
      ,[carg_UsuarioModificador]
      ,[carg_FechaModificacion]
  FROM [parq].[tbCargos]


--*************** SELECT DE CARGOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_SELECT
AS
BEGIN
	SELECT [carg_ID]
      ,[carg_Nombre]
      ,[carg_Habilitado]
      ,[carg_Estado]
      ,[carg_UsuarioCreador]
      ,[carg_FechaCreacion]
      ,[carg_UsuarioModificador]
      ,[carg_FechaModificacion]
  FROM [parq].[tbCargos]
  WHERE carg_Estado = 1  AND carg_Habilitado = 1
END

--*************** FIND DE CARGOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_FIND
@carg_ID INT
AS
BEGIN
	SELECT [carg_ID]
      ,[carg_Nombre]
      ,[carg_Habilitado]
      ,[carg_Estado]
      ,[carg_UsuarioCreador]
      ,[carg_FechaCreacion]
      ,[carg_UsuarioModificador]
      ,[carg_FechaModificacion]
  FROM [parq].[tbCargos]
  WHERE carg_Estado = 1  
  AND	carg_ID = @carg_ID
END

GO
--*************** INSERT DE CARGOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_INSERT
	@carg_Nombre			VARCHAR (300),
	@carg_UsuarioCreador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado  = 1 )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre del cargo ya existe' AS messageStatus
				 END
			 ELSE IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado  = 0)
				 BEGIN
				   UPDATE parq.tbCargos
						SET		carg_Estado = 1, carg_Habilitado = 1, carg_UsuarioModificador = @carg_UsuarioCreador
						WHERE	carg_Nombre = @carg_Nombre
					SELECT 200 AS codeStatus, 'Cargo creado con éxito' AS messageStatus
				 END
			  ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre)
				BEGIN
					INSERT INTO parq.tbCargos	(carg_Nombre, carg_UsuarioCreador)
					VALUES						(@carg_Nombre, @carg_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Cargo creado con éxito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE CARGO ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbCargo_UPDATE
	@carg_ID				INT,
	@carg_Nombre			VARCHAR (300),
	@carg_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado = 1 AND carg_ID != @carg_ID)
			 BEGIN
				SELECT 409 AS codeStatus, 'El nombre del cargo que quieres actualizar ya existe.' AS messageStatus
			 END
		IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado  = 0 AND carg_ID != @carg_ID)
			BEGIN
				UPDATE parq.tbCargos
				SET		carg_Nombre =	@carg_Nombre, carg_UsuarioModificador = @carg_UsuarioModificador
				WHERE	carg_ID   =		@carg_ID
				SELECT 200 AS codeStatus, 'Cargo actualizado con éxito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre)
				BEGIN
					UPDATE parq.tbCargos 
					SET carg_Nombre = @carg_Nombre, carg_UsuarioModificador = @carg_UsuarioModificador
					WHERE	carg_ID = @carg_ID
					SELECT 200 AS codeStatus, 'Cargo actualizado con éxito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

	END

--*************** DELETE DE ROL ******************-
GO

CREATE OR ALTER PROCEDURE parq.UDP_tbCargo_DELETE
@carg_Id INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @EmpleadoOcupa INT = (SELECT COUNT(*) FROM parq.tbEmpleados WHERE carg_ID = @carg_Id)
				IF @EmpleadoOcupa > 0
					BEGIN
						SELECT 500 AS codeStatus, 'El Cargo que desea eliminar esta en uso' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbCargos
							SET
							carg_Estado		=	0
							WHERE carg_ID	=	@carg_Id
							SELECT 200 AS codeStatus, 'Cargo eliminado con éxito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END