USE dbParqueAtracciones
GO




------------------------------------------------------- //// PROCS PARA tbEmpleados -- ///// ----------------------------------------------------

--*****************************************************--
--*************** VISTA DE EMPLEADOS ******************--

CREATE OR ALTER VIEW parq.VW_tbEmpleados
AS
	SELECT	empl.empl_ID, 
			empl_PrimerNombre, 
			empl_SegundoNombre, 
			empl_PrimerApellido, 
			empl_SegundoApellido, 
			CONCAT(empl_PrimerNombre, ' ' ,empl_SegundoNombre) AS empl_Nombres,
			CONCAT(empl_PrimerApellido, ' ', empl_SegundoApellido) AS empl_Apellidos,
			CONCAT(empl_PrimerNombre, ' ', empl_SegundoNombre, ' ', empl_PrimerApellido, ' ', empl_SegundoApellido) AS empl_NombreCompleto,
			empl_DNI, 
			empl_Email, 
			empl_Telefono, 
			empl_Sexo, 
			empl.civi_ID, 
			civi.civi_Descripcion,
			empl.carg_ID, 
			carg.carg_Nombre,
			empl_Habilitado, 
			empl_Estado, 
			empl_UsuarioCreador, 
			empl_FechaCreacion, 
			empl_UsuarioModificador, 
			empl_FechaModificacion
	FROM parq.tbEmpleados AS empl 
	INNER JOIN gral.tbEstadosCiviles AS civi ON empl.civi_ID = civi.civi_ID
	INNER JOIN parq.tbCargos AS carg ON empl.carg_ID = carg.carg_ID
	INNER JOIN acce.tbUsuarios AS usua1 ON empl.empl_UsuarioCreador = usua1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usua2 ON empl.empl_UsuarioModificador = usua2.usua_ID
GO

--*************** SELECT DE EMPLEADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbEmpleados_Select
AS
BEGIN
	SELECT * FROM parq.VW_tbEmpleados WHERE empl_Estado = 1 AND empl_Habilitado = 1
END
GO


--*************** FIND DE EMPLEADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbEmpleados_Find
	@empl_ID INT
AS
BEGIN
	SELECT * FROM parq.VW_tbEmpleados WHERE empl_ID = @empl_ID
END
GO

--*************** CREATE DE EMPLEADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbEmpleados_Insert
	@empl_PrimerNombre		VARCHAR(300), 
	@empl_SegundoNombre		VARCHAR (300),  
	@empl_PrimerApellido	VARCHAR (300), 
	@empl_SegundoApellido	VARCHAR (300), 
	@empl_DNI				CHAR(15), 
	@empl_Email				NVARCHAR(300), 
	@empl_Telefono			CHAR(9), 
	@empl_Sexo				CHAR(1),  
	@civi_ID				INT, 
	@carg_ID				INT, 
	@empl_UsuarioCreador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_DNI = @empl_DNI)
				BEGIN
					SELECT 409 AS codeStatus, 'Este DNI ya existe' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_Telefono = @empl_Telefono)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Teléfono ya existe' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_Email = @empl_Email)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Correo Electrónico ya existe' AS messageStatus
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbEmpleados(empl_PrimerNombre, empl_SegundoNombre, empl_PrimerApellido, empl_SegundoApellido, empl_DNI, empl_Email, empl_Telefono, empl_Sexo, civi_ID, carg_ID, empl_UsuarioCreador)
					VALUES(@empl_PrimerNombre, @empl_SegundoNombre, @empl_PrimerApellido, @empl_SegundoApellido, @empl_DNI, @empl_Email, @empl_Telefono, @empl_Sexo, @civi_ID, @carg_ID, @empl_UsuarioCreador)

					SELECT 200 AS codeStatus, 'Registro agregado exitosamente!' AS messageStatus
				END
		COMMIT
	END TRY 

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH 
END
GO

--*************** UPDATE DE EMPLEADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbEmpleados_Update
	@empl_ID					INT,
	@empl_PrimerNombre			VARCHAR(300), 
	@empl_SegundoNombre			VARCHAR (300),  
	@empl_PrimerApellido		VARCHAR (300), 
	@empl_SegundoApellido		VARCHAR (300), 
	@empl_DNI					CHAR(15), 
	@empl_Email					NVARCHAR(300), 
	@empl_Telefono				CHAR(9), 
	@empl_Sexo					CHAR(1),  
	@civi_ID					INT, 
	@carg_ID					INT, 
	@empl_UsuarioModificador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

			IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_DNI = @empl_DNI AND empl_ID != @empl_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Este DNI ya existe' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_Telefono = @empl_Telefono AND empl_ID != @empl_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Teléfono ya existe' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_Email = @empl_Email AND empl_ID != @empl_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Correo Electrónico ya existe' AS messageStatus
				END
			ELSE 
				BEGIN
					UPDATE parq.tbEmpleados 
					SET empl_PrimerNombre = @empl_PrimerNombre, 
						empl_SegundoNombre = @empl_SegundoNombre, 
						empl_PrimerApellido = @empl_PrimerApellido, 
						empl_SegundoApellido = @empl_SegundoApellido, 
						empl_DNI = @empl_DNI, 
						empl_Email = @empl_Email, 
						empl_Telefono = @empl_Telefono, 
						empl_Sexo = @empl_Sexo, 
						civi_ID = @civi_ID, 
						carg_ID = @carg_ID, 
						empl_UsuarioModificador = @empl_UsuarioModificador, 
						empl_FechaModificacion = GETDATE()
					WHERE empl_ID = @empl_ID
				END
		COMMIT
	END TRY

	BEGIN CATCH 
		ROLLBACK
			SELECT 500 AS statusCode, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*************** DELETE DE EMPLEADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbEmpleados_Delete
	@empl_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @QuioscosOcupando INT = (SELECT COUNT(*) FROM parq.tbQuioscos WHERE empl_ID = @empl_ID)
			DECLARE @UsuariosOcupando INT = (SELECT COUNT(*) FROM acce.tbUsuarios WHERE empl_ID = @empl_ID)

			IF @QuioscosOcupando > 0 OR @UsuariosOcupando > 0
				BEGIN
					SELECT 500 coseStatus, 'El Empleado que desea eliminar se encuentra en uso' AS messageStatus
				END
			ELSE
				BEGIN
					UPDATE parq.tbEmpleados
					SET empl_Estado = 0 
					WHERE empl_ID = @empl_ID

					SELECT 200 AS codeStatus, 'Empleado eliminado con éxito' AS messageStatus
				END
		COMMIT 
	END TRY

	BEGIN CATCH 
		ROLLBACK
			SELECT 500 AS statusCode, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO



