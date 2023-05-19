USE dbParqueAtracciones
GO

CREATE OR ALTER VIEW acce.VW_Usuarios
AS
SELECT  usua_ID,
        usua_Usuario,
        usua_Clave,
        T1.empl_Id,
        nombreEmpleado = CONVERT(VARCHAR,T2.empl_PrimerNombre+' '+T2.empl_PrimerApellido),
        usua_Admin,
        CASE WHEN usua_Admin  = 1 THEN 'SI'
        ELSE 'NO' END AS EsAdmin,
        T1.role_ID,
        CASE WHEN  role_Nombre is null THEN 'N/A' 
        ELSE role_Nombre END AS role_Descripcion,
        T1.usua_Estado,
        T1.usua_UsuarioCreador,
        (SELECT empl_PrimerNombre+' '+empl_PrimerApellido FROM parq.tbEmpleados
        WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE usua_ID = T1.usua_UsuarioCreador)) AS empl_Crea,
        usua_FechaCreacion,
        T1.usua_UsuarioModificador,
        (SELECT empl_PrimerNombre+' '+empl_PrimerApellido FROM parq.tbEmpleados 
        WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE usua_ID = T1.usua_UsuarioModificador)) AS empl_Modifica,
        usua_FechaModificacion
        FROM acce.tbUsuarios T1
        INNER JOIN parq.tbEmpleados T2
        ON T1.empl_ID = T2.empl_ID
        LEFT JOIN acce.tbRoles T3
        ON T1.role_Id = T3.role_Id
GO



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
	   , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = carg_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = carg_UsuarioModificador)
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
				SELECT 200 AS codeStatus, 'Cargo actualizado con éxito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_ID != @carg_ID)
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
							SELECT 200 AS codeStatus, 'Cargo eliminado con éxito' AS messageStatus
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
	  , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = regi_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = regi_UsuarioModificador)
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
					SELECT 409 AS codeStatus, 'El nombre de la región ya existe' AS messageStatus
				 END
			 ELSE IF EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre AND regi_Estado  = 0)
				 BEGIN
				   UPDATE parq.tbRegiones
						SET		regi_Estado = 1, regi_Habilitado = 1, regi_UsuarioModificador = @regi_UsuarioCreador
						WHERE	regi_Nombre = @regi_Nombre
					SELECT 200 AS codeStatus, 'Región creada con éxito' AS messageStatus
				 END
			  ELSE IF NOT EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre)
				BEGIN
					INSERT INTO parq.tbRegiones	(regi_Nombre, regi_UsuarioCreador)
					VALUES						(@regi_Nombre, @regi_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Región creada con éxito' AS messageStatus
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
				SELECT 409 AS codeStatus, 'El nombre de la región que quieres actualizar ya existe en otro registro.' AS messageStatus
			 END
		IF EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre AND regi_Estado = 1 AND regi_ID != @regi_ID)
			BEGIN
				UPDATE parq.tbRegiones
				SET		regi_Nombre =	@regi_Nombre, regi_UsuarioModificador = @regi_UsuarioModificador
				WHERE	regi_ID   =		@regi_ID
				SELECT 200 AS codeStatus, 'Región actualizada con éxito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre)
				BEGIN
					UPDATE parq.tbRegiones 
					SET regi_Nombre = @regi_UsuarioModificador, regi_UsuarioModificador = @regi_UsuarioModificador
					WHERE	regi_ID = @regi_ID
					SELECT 200 AS codeStatus, 'Región actualizada con éxito' AS messageStatus
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
						SELECT 500 AS codeStatus, 'La región que desea eliminar está en uso' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbRegiones
							SET
							regi_Estado		=	0
							WHERE regi_ID	=	@regi_ID
							SELECT 200 AS codeStatus, 'Región eliminada con éxito' AS messageStatus
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
	  , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = clie_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = clie_UsuarioModificador)
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
				SELECT 409 AS codeStatus, 'El DNI que digitó ya se encuentra registrado.' AS messageStatus
			 END
			 ELSE IF NOT EXISTS (SELECT * FROM parq.tbClientes WHERE clie_DNI = @clie_DNI)
			 BEGIN
				INSERT INTO parq.tbClientes([clie_Nombres], [clie_Apellidos],[clie_DNI],[clie_Sexo], [clie_Telefono], [clie_UsuarioCreador])
				VALUES						(@clie_Nombres, @clie_Apellidos, @clie_DNI, @clie_Sexo, @clie_Telefono, @clie_UsuarioCreador)
				SELECT 200 AS codeStatus, 'Cliente registrado con éxito' AS messageStatus
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
					SELECT 200 AS codeStatus, 'Cliente actualizado con éxito' AS messageStatus
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
						SELECT 500 AS codeStatus, 'El Cliente que desea eliminar está en uso' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbClientes
							SET
							clie_Estado		=	0
							WHERE clie_ID	=	@clie_ID
							SELECT 200 AS codeStatus, 'Cliente eliminado con éxito' AS messageStatus
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
      ,[clre_Contraseña]
      ,[clre_Habilitado]
      ,[clre_Estado]
      ,[clre_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Creador
      ,[clre_FechaCreacion]
      ,[clre_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modificador
      ,[clre_FechaModificacion]
	   , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = clre_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = clre_UsuarioModificador)
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
	@clre_Contraseña		NVARCHAR(300), 
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

				DECLARE @CLAVE2 VARBINARY (MAX) = HASHBYTES('SHA2_512', @clre_Contraseña)
				DECLARE @INCRI2 VARCHAR(MAX) = CONVERT(VARCHAR(MAX), @CLAVE2 ,2)

				INSERT INTO parq.tbClientesRegistrados([clie_ID], [clre_Usuario],[clre_Email], [clre_Contraseña], [clre_UsuarioCreador])
				VALUES								  (@clie_ID, @clre_Usuario, @clre_Email, @INCRI2, @clre_UsuarioCreador)
				SELECT 200 AS codeStatus, 'El usuario fue registrado con éxito' AS messageStatus
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
				SELECT 200 AS codeStatus, 'El usuario fue actualizado con éxito' AS messageStatus
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
				SET		clre_Estado	=	0
				WHERE   clre_ID	= @clre_ID
				SELECT 200 AS codeStatus, 'Usuario eliminado con éxito' AS messageStatus	
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO


------------------------------------------------------- //// PROCS PARA tbAreas -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE AREAS ******************--
CREATE OR ALTER VIEW parq.VW_tbAreas
AS
SELECT [area_ID]
      ,[area_Nombre]
      ,[area_Descripcion]
      ,areas.regi_ID
	  ,regi.regi_Nombre
      ,[area_UbicaionReferencia]
      ,[area_Imagen]
      ,[area_Habilitado]
      ,[area_Estado]
      ,[area_UsuarioCreador]
	  ,usu1.usua_Usuario AS usua_Creador
      ,[area_FechaCreacion]
      ,[area_UsuarioModificador]
	  ,usu2.usua_Usuario AS usua_Modificar
      ,[area_FechaModificacion]
	   , empl_crea =	(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = area_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = area_UsuarioModificador)
  FROM [parq].[tbAreas] areas
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = areas.area_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = areas.area_UsuarioModificador
  INNER JOIN parq.tbRegiones regi ON areas.regi_ID = regi.regi_ID

--*************** SELECT DE AREAS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAreas_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbAreas
	WHERE area_Estado = 1  AND area_Habilitado = 1
END

--*************** FIND DE AREAS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAreas_FIND
@area_ID INT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbAreas
	WHERE area_Estado = 1  
	AND	area_ID = @area_ID
END

GO
--*************** INSERT DE AREAS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbAreas_INSERT
	@area_Nombre				VARCHAR(300), 
	@area_Descripcion			VARCHAR(300), 
	@regi_ID					INT, 
	@area_UbicaionReferencia	VARCHAR(300), 
	@area_Imagen				NVARCHAR(MAX), 
	@area_UsuarioCreador		INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre AND area_Estado  = 1 )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre del area ya existe' AS messageStatus
				 END
			 ELSE IF EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre AND area_Estado  = 0)
				 BEGIN
				   UPDATE parq.tbAreas
						SET		area_Estado = 1, area_Habilitado = 1 ,
								area_Descripcion = @area_Descripcion,
								regi_ID = @regi_ID, area_UbicaionReferencia = @area_UbicaionReferencia,
								area_Imagen = @area_Imagen , area_UsuarioModificador = @area_UsuarioCreador
						WHERE	area_Nombre = @area_Nombre
					SELECT 200 AS codeStatus, 'Area creada con éxito' AS messageStatus
				 END
		    ELSE IF NOT EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre)
				BEGIN
					INSERT INTO parq.tbAreas(area_Nombre, area_Descripcion, regi_ID, area_UbicaionReferencia, area_Imagen, area_UsuarioCreador)
					VALUES					(@area_Nombre, @area_Descripcion, @regi_ID, @area_UbicaionReferencia, @area_Imagen, @area_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Area creada con éxito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE AREAS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAreas_UPDATE
	@area_ID					INT,
	@area_Nombre				VARCHAR(300), 
	@area_Descripcion			VARCHAR(300), 
	@regi_ID					INT, 
	@area_UbicaionReferencia	VARCHAR(300), 
	@area_Imagen				NVARCHAR(MAX), 
	@area_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre AND area_Estado  = 1 AND area_ID != @area_ID )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre del area que quiere actualizar ya existe en otro registro.' AS messageStatus
				 END
		IF EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre AND area_Estado  = 0 AND area_ID != @area_ID)
			BEGIN
				UPDATE parq.tbAreas
				SET		area_Nombre =	@area_Nombre, 
						area_Descripcion = @area_Descripcion,
						regi_Id = @regi_ID,
						area_UbicaionReferencia = @area_UbicaionReferencia,
						area_Imagen = @area_Imagen,
						area_UsuarioModificador = @area_UsuarioModificador
				WHERE	area_ID   =		@area_ID
				SELECT 200 AS codeStatus, 'Area actualizada con éxito' AS messageStatus
			END
		 ELSE IF NOT EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre AND area_ID != @area_ID )
			BEGIN
					UPDATE parq.tbAreas
				SET		area_Nombre =	@area_Nombre, 
						area_Descripcion = @area_Descripcion,
						regi_Id = @regi_ID,
						area_UbicaionReferencia = @area_UbicaionReferencia,
						area_Imagen = @area_Imagen,
						area_UsuarioModificador = @area_UsuarioModificador
				WHERE	area_ID   =		@area_ID
				SELECT 200 AS codeStatus, 'Area actualizada con éxito' AS messageStatus
			END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

--*************** DELETE DE AREA ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAreas_DELETE
	@area_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
				
				DECLARE @QuioscosOcupa	  INT = (SELECT COUNT(*) FROM parq.tbQuioscos WHERE area_ID =	@area_ID)
				DECLARE @AtraccionesOcupa INT = (SELECT COUNT(*) FROM parq.tbAreas	  WHERE area_ID =	@area_ID)
				DECLARE @RegionesEnUso INT = @QuioscosOcupa + @AtraccionesOcupa

				IF	@RegionesEnUso > 0
					BEGIN
						SELECT 500 AS codeStatus, 'El area que desea eliminar está en uso.' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbAreas
							SET area_Estado	= 0 WHERE area_Estado =	@area_ID
						SELECT 200 AS codeStatus, 'Area eliminada con éxito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO


------------------------------------------------------- //// PROCS PARA tbTickets -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE TICKET ******************--
CREATE OR ALTER VIEW parq.VW_tbTickets
AS
SELECT [tckt_ID]
      ,[tckt_Nombre]
      ,[tckt_Precio]
      ,[tckt_Habilitado]
      ,[tckt_Estado]
      ,[tckt_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Creador
      ,[tckt_FechaCreacion]
      ,[tckt_UsuarioModificador]
	  ,usu2.usua_UsuarioModificador AS usu_Modificador
      ,[tckt_FechaModificacion]
	  , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = tckt_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = tckt_UsuarioModificador)
  FROM [parq].[tbTickets] tickets
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = tickets.tckt_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = tickets.tckt_UsuarioModificador

--*************** SELECT DE TICKETS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbTickets
	WHERE tckt_Estado = 1  AND tckt_Habilitado = 1
END

--*************** FIND DE TICKETS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_FIND
@tckt_ID INT
AS
BEGIN
	SELECT *
	FROM	[parq].VW_tbTickets
	WHERE	tckt_Estado = 1  
	AND		tckt_ID = @tckt_ID
END

GO
--*************** INSERT DE TICKETS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_INSERT
	@tckt_Nombre		 VARCHAR(300), 
	@tckt_Precio		 INT, 
	@tckt_UsuarioCreador INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre AND tckt_Estado  = 1 )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre del ticket ya existe.' AS messageStatus
				 END
			 ELSE IF EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre AND tckt_Estado  = 0)
				 BEGIN
				   UPDATE parq.tbTickets
						SET		tckt_Estado = 1, tckt_Habilitado = 1 ,
								tckt_Nombre = @tckt_Nombre,
								tckt_Precio = @tckt_Precio,
								tckt_UsuarioCreador = @tckt_UsuarioCreador
					WHERE		tckt_Nombre = @tckt_Nombre
					SELECT 200 AS codeStatus, 'Ticket creado con éxito' AS messageStatus
				 END
		    ELSE IF NOT EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre)
				BEGIN
					INSERT INTO parq.tbTickets(tckt_Nombre, tckt_Precio, tckt_UsuarioCreador)
					VALUES					  (@tckt_Nombre, @tckt_Precio, @tckt_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Ticket creado con éxito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE TICKETS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_UPDATE
	@tckt_ID					INT,
	@tckt_Nombre				VARCHAR(300), 
	@tckt_Precio				INT, 
	@tckt_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre AND tckt_Estado  = 1 AND tckt_ID != @tckt_ID )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre del ticket que quiere actualizar ya existe en otro registro.' AS messageStatus
				 END
		IF EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre AND tckt_Estado  = 0 AND tckt_ID != @tckt_ID)
			BEGIN
				UPDATE parq.tbTickets
				SET		tckt_Nombre =	@tckt_Nombre, 
						tckt_Precio = @tckt_Precio,
						tckt_UsuarioModificador = @tckt_UsuarioModificador
				WHERE	tckt_ID   =		@tckt_ID
				SELECT 200 AS codeStatus, 'Ticket actualizado con éxito' AS messageStatus
			END
		 ELSE IF NOT EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre AND tckt_ID != @tckt_ID )
			BEGIN
				UPDATE parq.tbTickets
				SET		tckt_Nombre =	@tckt_Nombre, 
						tckt_Precio = @tckt_Precio,
						tckt_UsuarioModificador = @tckt_UsuarioModificador
				WHERE	tckt_ID   =		@tckt_ID
				SELECT 200 AS codeStatus, 'Ticket actualizado con éxito' AS messageStatus
			END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

--*************** DELETE DE TICKETS ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_DELETE
	@tckt_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
				
				DECLARE @ClienteOcupa	 INT = (SELECT COUNT(*) FROM parq.tbTicketsCliente WHERE tckt_ID =	@tckt_ID)
				

				IF	@ClienteOcupa > 0
					BEGIN
						SELECT 500 AS codeStatus, 'El Ticket que desea eliminar está en uso.' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbTickets
							SET tckt_Estado	= 0 WHERE tckt_ID =	@tckt_ID
						SELECT 200 AS codeStatus, 'Ticket eliminado con éxito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO



------------------------------------------------------- //// PROCS PARA tbTicketsClientes -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE TICKETCLIENTES ******************--
CREATE OR ALTER VIEW parq.VW_tbTicketClientes
AS
SELECT [ticl_ID]
      ,[tckt_ID]
      ,[clie_ID]
      ,[ticl_Cantidad]
      ,[ticl_FechaCompra]
      ,[ticl_FechaUso]
      ,[ticl_Habilitado]
      ,[ticl_Estado]
      ,[ticl_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Crea
      ,[ticl_FechaCreacion]
      ,[ticl_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modifica
      ,[ticl_FechaModificacion]
	  , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = ticl_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = ticl_UsuarioModificador)
  FROM [parq].[tbTicketsCliente] tcli
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = tcli.ticl_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = tcli.ticl_UsuarioModificador

--*************** SELECT DE TICKETCLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTicketClientes_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbTicketClientes
	WHERE ticl_Estado = 1  AND ticl_Habilitado = 1
END

--*************** FIND DE TICKETCLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTicketClientes_FIND
@ticl_ID INT
AS
BEGIN
	SELECT *
	FROM	[parq].VW_tbTicketClientes
	WHERE	ticl_Estado = 1  
	AND		ticl_ID = @ticl_ID
END

GO
--*************** INSERT DE TICKETCLIENTES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbTicketClientes_INSERT
	@tckt_ID				INT, 
	@clie_ID				INT, 
	@ticl_Cantidad			INT, 
	@ticl_FechaCompra		DATETIME, 
	@ticl_FechaUso			DATETIME, 
	@ticl_UsuarioCreador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
					INSERT INTO parq.tbTicketsCliente(tckt_ID, clie_ID, ticl_Cantidad, ticl_FechaCompra, ticl_FechaUso, ticl_UsuarioCreador)
					VALUES							 (@tckt_ID, @clie_ID, @ticl_Cantidad, @ticl_FechaCompra, @ticl_FechaUso, @ticl_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Ticket Detalle creado con éxito' AS messageStatus
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE TICKETCLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_UPDATE
	@ticl_ID				INT,
	@tckt_ID				INT, 
	@clie_ID				INT, 
	@ticl_Cantidad			INT, 
	@ticl_FechaCompra		DATETIME, 
	@ticl_FechaUso			DATETIME, 
	@ticl_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		
				UPDATE parq.tbTicketsCliente
				SET		tckt_ID =	@tckt_ID, 
						clie_ID = @clie_ID,
						ticl_Cantidad = @ticl_Cantidad,
						ticl_FechaCompra = @ticl_FechaCompra,
						ticl_FechaUso = @ticl_FechaUso,
						ticl_UsuarioModificador = @ticl_UsuarioModificador
				WHERE	ticl_ID   =		@ticl_ID
				SELECT 200 AS codeStatus, 'Ticket Detalle actualizado con éxito' AS messageStatus
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

--*************** DELETE DE TICKETCLIENTES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbTickets_DELETE
	@ticl_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
				
				DECLARE @TemporizadorOcupa	 INT = (SELECT COUNT(*) FROM fila.tbTemporizadores		WHERE ticl_ID =	@ticl_ID)
				DECLARE @VisitantesAtraccion			INT = (SELECT COUNT(*) FROM  fila.tbVisitantesAtraccion WHERE ticl_ID = @ticl_ID)
				DECLARE @TicketsClientesOcupa INT = @TemporizadorOcupa + @VisitantesAtraccion

				IF	@TicketsClientesOcupa > 0
					BEGIN
						SELECT 500 AS codeStatus, 'El Ticket Detalle que desea eliminar está en uso.' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.VW_tbTicketClientes
							SET ticl_Estado	= 0 WHERE ticl_ID =	@ticl_ID
						SELECT 200 AS codeStatus, 'Ticket Detalle eliminado con éxito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

------------------------------------------------------- //// PROCS PARA tbAtracciones -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE ATRACCIONES ******************--
CREATE OR ALTER VIEW parq.VW_tbAtracciones
AS
SELECT TOP (1000) [atra_ID]
      ,[area_ID]
      ,[atra_Nombre]
      ,[atra_Descripcion]
      ,atracc.regi_ID
	  ,regi.regi_Nombre
      ,[atra_ReferenciaUbicacion]
      ,[atra_LimitePersonas]
      ,[atra_DuracionRonda]
      ,[atra_Imagen]
      ,[atra_Habilitado]
      ,[atra_Estado]
      ,[atra_UsuarioCreador]
	  ,usu1.usua_Usuario AS usu_Crea
      ,[atra_FechaCreacion]
      ,[atra_UsuarioModificador]
	  ,usu2.usua_Usuario AS usu_Modifica
      ,[atra_FechaModificacion]
	  , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = atra_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = atra_UsuarioModificador)
    FROM [parq].[tbAtracciones] atracc
  INNER JOIN acce.tbUsuarios usu1
  ON	usu1.usua_ID = atracc.atra_UsuarioCreador	LEFT  JOIN acce.tbUsuarios usu2
  ON	usu2.usua_ID = atracc.atra_UsuarioModificador
  INNER JOIN parq.tbRegiones regi ON atracc.regi_ID = regi.regi_ID

--*************** SELECT DE ATRACCIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbAtracciones
	WHERE atra_Estado = 1  AND atra_Habilitado = 1
END

--*************** FIND DE ATRACCIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_FIND
@atra_ID INT
AS
BEGIN
	SELECT *
	FROM	[parq].VW_tbAtracciones
	WHERE	atra_Estado = 1  
	AND		atra_ID = @atra_ID
END

GO
--*************** INSERT DE ATRACCIONES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_INSERT
	@area_ID					INT, 
	@atra_Nombre				VARCHAR(300), 
	@atra_Descripcion			VARCHAR(300), 
	@regi_ID					INT, 
	@atra_ReferenciaUbicacion	VARCHAR(300), 
	@atra_LimitePersonas		INT, 
	@atra_DuracionRonda			TIME(7), 
	@atra_Imagen				NVARCHAR(MAX),
	@atra_UsuarioCreador		INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
					INSERT INTO parq.tbAtracciones(area_ID, atra_Nombre, atra_Descripcion, regi_ID, atra_ReferenciaUbicacion, atra_LimitePersonas, atra_DuracionRonda, atra_Imagen, atra_UsuarioCreador)
					VALUES						 (@area_ID, @atra_Nombre, @atra_Descripcion, @regi_ID, @atra_ReferenciaUbicacion, @atra_LimitePersonas, @atra_DuracionRonda, @atra_Imagen, @atra_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Atraccion creada con éxito' AS messageStatus
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
--*************** UPDATE DE ATRACCIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_UPDATE
	@atra_ID					INT,
	@area_ID					INT, 
	@atra_Nombre				VARCHAR(300), 
	@atra_Descripcion			VARCHAR(300), 
	@regi_ID					INT, 
	@atra_ReferenciaUbicacion	VARCHAR(300), 
	@atra_LimitePersonas		INT, 
	@atra_DuracionRonda			TIME(7), 
	@atra_Imagen				NVARCHAR(MAX),
	@atra_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
				UPDATE parq.tbAtracciones
				SET		area_ID =	@area_ID, 
						atra_Nombre = @atra_Nombre,
						regi_ID = @regi_ID,
						atra_ReferenciaUbicacion = @atra_ReferenciaUbicacion,
						atra_DuracionRonda = @atra_DuracionRonda,
						atra_Imagen = @atra_Imagen,
						atra_UsuarioModificador = @atra_UsuarioModificador
				WHERE	atra_ID   =		@atra_ID
				SELECT 200 AS codeStatus, 'Atraccion actualizada con éxito' AS messageStatus
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

--*************** DELETE DE ATRACCIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_DELETE
	@atra_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
				
				DECLARE @RatingsOcupa		  INT = (SELECT COUNT(*) FROM parq.tbRatings			  WHERE atra_ID =	@atra_ID)
				DECLARE @VisitantesAtraccion  INT = (SELECT COUNT(*) FROM fila.tbVisitantesAtraccion  WHERE atra_ID = @atra_ID)
				DECLARE @FilaAtraccion		  INT = (SELECT COUNT(*) FROM fila.tbFilasAtraccion		  WHERE atra_ID = @atra_ID)
				DECLARE @TicketsClientesOcupa INT = @RatingsOcupa + @VisitantesAtraccion + @FilaAtraccion

				IF	@TicketsClientesOcupa > 0
					BEGIN
						SELECT 500 AS codeStatus, 'La Atraccion que desea eliminar está en uso.' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.VW_tbAtracciones
							SET atra_Estado	= 0 WHERE atra_ID =	@atra_ID
						SELECT 200 AS codeStatus, 'Atraccion eliminado con éxito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END