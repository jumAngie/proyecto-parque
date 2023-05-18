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
	  ,usu1.usua_Usuario AS usu_Creador
      ,[carg_FechaCreacion]
      ,[carg_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modificador
      ,[carg_FechaModificacion]
  FROM [parq].[tbCargos] carg					
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = carg.carg_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = carg.carg_UsuarioModificador


--*************** SELECT DE CARGOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_SELECT
AS
BEGIN
	SELECT *
  FROM [parq].VW_tbCargos
  WHERE carg_Estado = 1  AND carg_Habilitado = 1
END

--*************** FIND DE CARGOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_FIND
@carg_ID INT
AS
BEGIN
	SELECT *
  FROM [parq].VW_tbCargos
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
					SELECT 200 AS codeStatus, 'Cargo creado con �xito' AS messageStatus
				 END
			  ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre)
				BEGIN
					INSERT INTO parq.tbCargos	(carg_Nombre, carg_UsuarioCreador)
					VALUES						(@carg_Nombre, @carg_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Cargo creado con �xito' AS messageStatus
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
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_UPDATE
	@carg_ID				INT,
	@carg_Nombre			VARCHAR (300),
	@carg_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado = 1 AND carg_ID != @carg_ID)
			 BEGIN
				SELECT 409 AS codeStatus, 'El nombre del cargo que quieres actualizar ya existe en otro registro.' AS messageStatus
			 END
		IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado  = 0 AND carg_ID != @carg_ID)
			BEGIN
				UPDATE parq.tbCargos
				SET		carg_Nombre =	@carg_Nombre, carg_UsuarioModificador = @carg_UsuarioModificador
				WHERE	carg_ID   =		@carg_ID
				SELECT 200 AS codeStatus, 'Cargo actualizado con �xito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre)
				BEGIN
					UPDATE parq.tbCargos 
					SET carg_Nombre = @carg_Nombre, carg_UsuarioModificador = @carg_UsuarioModificador
					WHERE	carg_ID = @carg_ID
					SELECT 200 AS codeStatus, 'Cargo actualizado con �xito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

	END

--*************** DELETE DE CARGO ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_DELETE
@carg_Id INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN			DECLARE @EmpleadoOcupa INT = (SELECT COUNT(*) FROM parq.tbEmpleados WHERE carg_ID = @carg_Id)
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
							SELECT 200 AS codeStatus, 'Cargo eliminado con �xito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

------------------------------------------------------- //// PROCS PARA tbRegiones -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE REGIONES ******************--

GO
CREATE OR ALTER VIEW parq.VW_tbRegiones
AS
SELECT [regi_ID]
      ,[regi_Nombre]
      ,[regi_Habilitado]
      ,[regi_Estado]
      ,[regi_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Creador
      ,[regi_FechaCreacion]
      ,[regi_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modificador
      ,[regi_FechaModificacion]
  FROM [parq].[tbRegiones] regi
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = regi.regi_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = regi.regi_UsuarioModificador

--*************** SELECT DE REGIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbRegiones_SELECT
AS
BEGIN
	SELECT  *
	FROM	parq.VW_tbRegiones
	WHERE regi_Estado = 1  AND regi_Habilitado = 1
END

--*************** FIND DE REGIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbRegiones_FIND
@regi_ID INT
AS
BEGIN
	SELECT *
  FROM parq.VW_tbRegiones
  WHERE regi_Estado = 1  
  AND	regi_ID = @regi_ID
END

GO
--*************** INSERT DE REGIONES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbRegiones_INSERT
	@regi_Nombre			VARCHAR (200),
	@regi_UsuarioCreador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre AND regi_Estado  = 1 )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre de la regi�n ya existe' AS messageStatus
				 END
			 ELSE IF EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre AND regi_Estado  = 0)
				 BEGIN
				   UPDATE parq.tbRegiones
						SET		regi_Estado = 1, regi_Habilitado = 1, regi_UsuarioModificador = @regi_UsuarioCreador
						WHERE	regi_Nombre = @regi_Nombre
					SELECT 200 AS codeStatus, 'Regi�n creada con �xito' AS messageStatus
				 END
			  ELSE IF NOT EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre)
				BEGIN
					INSERT INTO parq.tbRegiones	(regi_Nombre, regi_UsuarioCreador)
					VALUES						(@regi_Nombre, @regi_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Regi�n creada con �xito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE REGIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbRegiones_UPDATE
	@regi_ID				INT,
	@regi_Nombre			VARCHAR (200),
	@regi_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre AND regi_Estado = 1 AND regi_ID != @regi_ID)
			 BEGIN
				SELECT 409 AS codeStatus, 'El nombre de la regi�n que quieres actualizar ya existe en otro registro.' AS messageStatus
			 END
		IF EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre AND regi_Estado = 1 AND regi_ID != @regi_ID)
			BEGIN
				UPDATE parq.tbRegiones
				SET		regi_Nombre =	@regi_Nombre, regi_UsuarioModificador = @regi_UsuarioModificador
				WHERE	regi_ID   =		@regi_ID
				SELECT 200 AS codeStatus, 'Regi�n actualizada con �xito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre)
				BEGIN
					UPDATE parq.tbRegiones 
					SET regi_Nombre = @regi_UsuarioModificador, regi_UsuarioModificador = @regi_UsuarioModificador
					WHERE	regi_ID = @regi_ID
					SELECT 200 AS codeStatus, 'Regi�n actualizada con �xito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

	END

--*************** DELETE DE REGIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbRegiones_DELETE
@regi_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 

			DECLARE @QuioscosOcupa    INT =	(SELECT COUNT(*) FROM parq.tbQuioscos		WHERE regi_ID =	@regi_ID)
			DECLARE @AtraccionesOcupa INT = (SELECT COUNT(*) FROM parq.tbAtracciones	WHERE regi_ID =	@regi_ID)
			DECLARE @AreasOcupa       INT =	(SELECT COUNT(*) FROM parq.tbAreas			WHERE regi_ID =	@regi_ID)

			DECLARE @RegionesEnUso INT = @QuioscosOcupa + @AtraccionesOcupa + @AreasOcupa

				IF	@RegionesEnUso > 0
					BEGIN
						SELECT 500 AS codeStatus, 'La regi�n que desea eliminar est� en uso' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbRegiones
							SET
							regi_Estado		=	0
							WHERE regi_ID	=	@regi_ID
							SELECT 200 AS codeStatus, 'Regi�n eliminada con �xito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

------------------------------------------------------- //// PROCS PARA tbClientes -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE CLIENTES ******************--
CREATE OR ALTER VIEW parq.VW_tbClientes
AS
SELECT [clie_ID]
      ,[clie_Nombres]
      ,[clie_Apellidos]
      ,[clie_DNI]
      ,[clie_Sexo]
      ,[clie_Telefono]
      ,[clie_Habilitado]
      ,[clie_Estado]
      ,[clie_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Creador
      ,[clie_FechaCreacion]
      ,[clie_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modificador
      ,[clie_FechaModificacion]
  FROM [parq].[tbClientes] clie
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = clie.clie_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = clie.clie_UsuarioModificador

--*************** SELECT DE CLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_SELECT
AS
BEGIN
	SELECT *
  FROM [parq].VW_tbClientes
  WHERE clie_Estado = 1  AND clie_Habilitado = 1
END

--*************** FIND DE CLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_FIND
@clie_ID INT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbClientes
	WHERE clie_Estado = 1  
	AND	clie_ID = @clie_ID
END

GO
--*************** INSERT DE CLIENTES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_INSERT
	@clie_Nombres			VARCHAR(300), 
	@clie_Apellidos			VARCHAR(300), 
	@clie_DNI				CHAR(15), 
	@clie_Sexo				CHAR(1), 
	@clie_Telefono			CHAR(9), 
	@clie_UsuarioCreador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM parq.tbClientes WHERE clie_DNI = @clie_DNI)
			 BEGIN
				SELECT 409 AS codeStatus, 'El DNI que digit� ya se encuentra registrado.' AS messageStatus
			 END
			 ELSE IF NOT EXISTS (SELECT * FROM parq.tbClientes WHERE clie_DNI = @clie_DNI)
			 BEGIN
				INSERT INTO parq.tbClientes([clie_Nombres], [clie_Apellidos],[clie_DNI],[clie_Sexo], [clie_Telefono], [clie_UsuarioCreador])
				VALUES						(@clie_Nombres, @clie_Apellidos, @clie_DNI, @clie_Sexo, @clie_Telefono, @clie_UsuarioCreador)
				SELECT 200 AS codeStatus, 'Cliente registrado con �xito' AS messageStatus
			 END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE CLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_UPDATE
	@clie_ID					INT,
	@clie_Nombres				VARCHAR(300), 
	@clie_Apellidos				VARCHAR(300), 
	@clie_DNI					CHAR(15), 
	@clie_Sexo					CHAR(1), 
	@clie_Telefono				CHAR(9), 
	@clie_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM parq.tbClientes WHERE clie_DNI = @clie_DNI AND clie_ID != @clie_ID)
			 BEGIN
				SELECT 409 AS codeStatus, 'El DNI que quieres actualizar ya existe en otro registro.' AS messageStatus
			 END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbClientes WHERE clie_DNI = @clie_DNI AND clie_ID != @clie_ID)
				BEGIN
					UPDATE parq.tbClientes 
					SET		clie_Nombres =  @clie_Nombres, clie_Apellidos = @clie_Apellidos, clie_DNI = @clie_DNI,
							clie_Sexo = @clie_Sexo, clie_Telefono = @clie_Telefono, clie_UsuarioModificador = @clie_UsuarioModificador
					WHERE	clie_ID = @clie_ID
					SELECT 200 AS codeStatus, 'Cliente actualizado con �xito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

	END

--*************** DELETE DE CLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_DELETE
	@clie_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 

			DECLARE @TicketsClientesOcupa		INT = (SELECT COUNT(*) FROM parq.tbTicketsCliente		WHERE clie_ID =	@clie_ID)
			DECLARE @ClientesRegistradosOcupa	INT = (SELECT COUNT(*) FROM parq.tbClientesRegistrados	WHERE clie_ID =	@clie_ID)
			DECLARE @RatingsOcupa				INT = (SELECT COUNT(*) FROM parq.tbRatings				WHERE clie_ID =	@clie_ID)
			DECLARE @VentasQuioscoOcupa			INT = (SELECT COUNT(*) FROM fact.tbVentasQuiosco		WHERE clie_ID =	@clie_ID)

			DECLARE @EnUso INT = @TicketsClientesOcupa + @ClientesRegistradosOcupa + @RatingsOcupa + @VentasQuioscoOcupa

				IF	@EnUso > 0
					BEGIN
						SELECT 500 AS codeStatus, 'El Cliente que desea eliminar est� en uso' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbClientes
							SET
							clie_Estado		=	0
							WHERE clie_ID	=	@clie_ID
							SELECT 200 AS codeStatus, 'Cliente eliminado con �xito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO


------------------------------------------------------- //// PROCS PARA tbClientesRegistrados -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE CLIENTESREGISTRADOS ******************--
CREATE OR ALTER VIEW parq.VW_tbClientesRegistrados
AS
SELECT [clre_ID]
      ,[clie_ID]
      ,[clre_Usuario]
      ,[clre_Email]
      ,[clre_Contrase�a]
      ,[clre_Habilitado]
      ,[clre_Estado]
      ,[clre_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Creador
      ,[clre_FechaCreacion]
      ,[clre_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modificador
      ,[clre_FechaModificacion]
  FROM parq.tbClientesRegistrados clire
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = clire.clre_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = clire.clre_UsuarioModificador

--*************** SELECT DE CLIENTESREGISTRADOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbClientesRegistrados
	WHERE clre_Estado = 1  AND clre_Habilitado = 1
END

--*************** FIND DE CLIENTESREGISTRADOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_FIND
@clre_Id INT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbClientesRegistrados
	WHERE clre_Estado = 1  
	AND	clre_ID = @clre_Id
END

GO
--*************** INSERT DE CLIENTESREGISTRADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_INSERT
	@clie_ID				INT,
	@clre_Usuario			VARCHAR(300), 
	@clre_Email				NVARCHAR(300), 
	@clre_Contrase�a		NVARCHAR(300), 
	@clre_UsuarioCreador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @UsuarioOcupado INT = 0
			DECLARE @EmailOcupado	INT = 0
			DECLARE @MessageStatus VARCHAR(20)

			IF EXISTS (SELECT * FROM parq.tbClientesRegistrados WHERE clre_Usuario = @clre_Usuario)
			 BEGIN
				SET @UsuarioOcupado = 1
				SET @MessageStatus = 'El Usuario ya existe'
			 END

			 IF EXISTS (SELECT * FROM parq.tbClientesRegistrados WHERE clre_Email = @clre_Email)
			 BEGIN
				SET @EmailOcupado = 1
				IF (@MessageStatus != '')
					BEGIN
						SET @MessageStatus += ', El E-mail ya existe.'
					END
			END
				ELSE
					BEGIN
						SET @MessageStatus = 'El E-mail ya existe.'
				END
			 IF (@UsuarioOcupado = 0 AND @EmailOcupado = 0)
			 BEGIN

				DECLARE @CLAVE2 VARBINARY (MAX) = HASHBYTES('SHA2_512', @clre_Contrase�a)
				DECLARE @INCRI2 VARCHAR(MAX) = CONVERT(VARCHAR(MAX), @CLAVE2 ,2)

				INSERT INTO parq.tbClientesRegistrados([clie_ID], [clre_Usuario],[clre_Email], [clre_Contrase�a], [clre_UsuarioCreador])
				VALUES								  (@clie_ID, @clre_Usuario, @clre_Email, @INCRI2, @clre_UsuarioCreador)
				SELECT 200 AS codeStatus, 'El usuario fue registrado con �xito' AS messageStatus
			 END
			 ELSE
				BEGIN
					SELECT 409 AS codeStatus, @MessageStatus as messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE CLIENTESREGISTRADOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_UPDATE
	@clre_ID					INT,
	@clie_ID					INT,
	@clre_Usuario				VARCHAR(300), 
	@clre_Email					NVARCHAR(300), 
	@clre_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

			DECLARE @UsuarioOcupado INT = 0
			DECLARE @EmailOcupado	INT = 0
			DECLARE @MessageStatus VARCHAR(20)

			IF EXISTS (SELECT * FROM parq.tbClientesRegistrados WHERE clre_Usuario = @clre_Usuario AND clre_ID != @clre_ID)
			 BEGIN
				SET @UsuarioOcupado = 1
				SET @MessageStatus = 'El Usuario ya existe'
			 END

			 IF EXISTS (SELECT * FROM parq.tbClientesRegistrados WHERE clre_Email = @clre_Email AND clre_ID != @clre_ID)
			 BEGIN
				SET @EmailOcupado = 1
				IF (@MessageStatus != '')
					BEGIN
						SET @MessageStatus += ', El E-mail ya existe.'
					END
			END
				ELSE
					BEGIN
						SET @MessageStatus = 'El E-mail ya existe.'
				END
			 IF (@UsuarioOcupado = 0 AND @EmailOcupado = 0)
			 BEGIN
				UPDATE parq.tbClientesRegistrados
				SET clie_ID = @clie_ID, clre_Usuario = @clre_Usuario, 
					clre_Email = @clre_Email, 
					clre_UsuarioModificador = @clre_UsuarioModificador
				WHERE clre_ID = @clre_ID
				SELECT 200 AS codeStatus, 'El usuario fue actualizado con �xito' AS messageStatus
			 END
			 ELSE
				BEGIN
					SELECT 409 AS codeStatus, @MessageStatus as messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

--*************** DELETE DE CLIENTESREGISTRADOS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_DELETE
	@clre_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
				UPDATE parq.tbClientesRegistrados
				SET clre_Estado	=	0
				WHERE clie_ID	=	@clre_ID
				SELECT 200 AS codeStatus, 'Usuario eliminado con �xito' AS messageStatus	
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END