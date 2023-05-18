USE dbParqueAtracciones
GO




CREATE OR ALTER VIEW acce.VW_Usuarios
AS
SELECT	usua_ID,
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
------------------------------------------------------- //// PROCS PARA tbEmpleados -- ///// ----------------------------------------------------


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
			
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = empl_UsuarioCreador),
			empl_Estado, 
			empl_UsuarioCreador, 
			usua1.usua_Usuario AS empl_UsuarioCreador_Nombre,
			empl_FechaCreacion, 
			empl_UsuarioModificador, 
			usua2.usua_Usuario AS empl_UsuarioModificador_Nombre,
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
CREATE OR ALTER PROCEDURE parq.UDP_tbEmpleados_Insert --'Alicia', 'Daniela', 'Zepeda', 'Fajardo', '0501200745578', 'AliZFajardo@gmail.com','9716-4669', 'F', 1, 1, 1
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

					SELECT 200 AS codeStatus, 'Empleado agregado con éxito!' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Empleado actualizado con éxito' AS messageStatus
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
CREATE OR ALTER PROCEDURE parq.UDP_tbEmpleados_Delete --2
	@empl_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @QuioscosOcupando INT = (SELECT COUNT(*) FROM parq.tbQuioscos WHERE empl_ID = @empl_ID)
			DECLARE @UsuariosOcupando INT = (SELECT COUNT(*) FROM acce.tbUsuarios WHERE empl_ID = @empl_ID)

			IF @QuioscosOcupando > 0 OR @UsuariosOcupando > 0
				BEGIN
					SELECT 409 coseStatus, 'El Empleado que desea eliminar se encuentra en uso' AS messageStatus
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





------------------------------------------------------- //// PROCS PARA tbQuioscos -- ///// ----------------------------------------------------

--*************** VISTA DE QUIOSCOS ******************--
CREATE OR ALTER VIEW parq.VW_tbQuioscos
AS
	SELECT	quio_ID, 
			area_Nombre, 
			area_Imagen, 	

			quio_Nombre, 
			quio.area_ID, 
			
			quio.empl_ID, 
			CONCAT(empl_PrimerNombre, ' ' ,empl_SegundoNombre) AS empl_Nombres,
			CONCAT(empl_PrimerApellido, ' ', empl_SegundoApellido) AS empl_Apellidos,
			CONCAT(empl_PrimerNombre, ' ', empl_SegundoNombre, ' ', empl_PrimerApellido, ' ', empl_SegundoApellido) AS empl_NombreCompleto,			
			empl.carg_ID,
			carg.carg_Nombre,

			quio.regi_ID,
			regi_Nombre,
			
			quio_ReferenciaUbicacion, 
			quio_Imagen, 
			quio_Habilitado, 
			
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = quio_UsuarioCreador),
			quio_Estado, 
			quio_UsuarioCreador, 
			usr1.usua_Usuario AS quio_UsuarioCreador_Nombre,
			quio_FechaCreacion, 
			quio_UsuarioModificador, 
			usr2.usua_Usuario AS quio_UsuarioModificador_Nombre,
			quio_FechaModificacion 
	FROM parq.tbQuioscos AS quio 
	INNER JOIN parq.tbAreas AS area ON quio.area_ID = area.area_ID
	INNER JOIN parq.tbEmpleados AS empl ON quio.empl_ID = empl.empl_ID
	INNER JOIN parq.tbRegiones AS regi ON quio.regi_ID = regi.regi_ID
	INNER JOIN acce.tbUsuarios AS usr1 ON quio.quio_UsuarioCreador = usr1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usr2 ON quio.quio_UsuarioModificador = usr2.usua_ID
	INNER JOIN parq.tbCargos AS carg ON empl.carg_ID = carg.carg_ID
GO

--*************** SELECT  DE QUISCOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbQuioscos_Select
AS
BEGIN
	SELECT * FROM parq.VW_tbQuioscos WHERE quio_Estado = 1 AND quio_Habilitado = 1
END
GO

--*************** FIND DE QUISCOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbQuioscos_Find
	@quio_ID INT
AS
BEGIN
	SELECT * FROM parq.VW_tbQuioscos WHERE quio_ID = @quio_ID
END
GO

--*************** CREATE DE QUISCOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbQuioscos_Insert --1, 'MiniShop', 2, 1, 'A media cuadra de la montaña rusa', '', 1
	@area_ID					INT, 
	@quio_Nombre				VARCHAR(300), 
	@empl_ID					INT, 
	@regi_ID					INT, 
	@quio_ReferenciaUbicacion	VARCHAR(300), 
	@quio_Imagen				NVARCHAR(MAX), 
	@quio_UsuarioCreador		INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT * FROM parq.tbQuioscos WHERE quio_Nombre = @quio_Nombre)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Nombre de quiosco ya existe' AS messageStatus
				END
			ELSE 
				BEGIN
					INSERT INTO parq.tbQuioscos(area_ID, quio_Nombre, empl_ID, regi_ID, quio_ReferenciaUbicacion, quio_Imagen, quio_UsuarioCreador)
					VALUES(@area_ID, @quio_Nombre, @empl_ID, @regi_ID, @quio_ReferenciaUbicacion, @quio_Imagen, @quio_UsuarioCreador)

					SELECT 200 AS codeStatus, 'Quiosco ingresado con éxito' AS messageStatus
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*************** UPDATE DE QUISCOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbQuioscos_Update
	@quio_ID					INT,
	@area_ID					INT, 
	@quio_Nombre				VARCHAR(300), 
	@empl_ID					INT, 
	@regi_ID					INT,	
	@quio_ReferenciaUbicacion	VARCHAR(300), 
	@quio_Imagen				NVARCHAR(MAX), 
	@quio_UsuarioModificador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT * FROM parq.tbQuioscos WHERE quio_Nombre = @quio_Nombre AND quio_ID != @quio_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Nombre de quiosco ya existe' AS messageStatus
				END
			ELSE 
				BEGIN
					UPDATE parq.tbQuioscos
					SET area_ID = @area_ID, 
						quio_Nombre = @quio_Nombre,
						empl_ID = @empl_ID, 
						regi_ID = @regi_ID, 
						quio_ReferenciaUbicacion = @quio_ReferenciaUbicacion, 
						quio_Imagen = @quio_Imagen, 
						quio_UsuarioModificador = @quio_UsuarioModificador, 
						quio_FechaModificacion = GETDATE()
					WHERE quio_ID = @quio_ID

					SELECT 200 AS codeStatus, 'Quiosco actualizado con éxito!' AS messageStatus
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK 
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*************** DELETE DE QUISCOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbQuioscos_Delete
	@quio_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE parq.tbQuioscos
			SET quio_Estado = 0
			WHERE quio_ID = @quio_ID

			SELECT 200 AS codeStatus, 'Quiosco eliminado con éxito' AS messageStatus
		COMMIT
	END TRY

	BEGIN CATCH 
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO





------------------------------------------------------- //// PROCS PARA tbGolosinas -- ///// ----------------------------------------------------

--*************** VISTA DE GOLOSINAS ******************--
CREATE OR ALTER VIEW parq.VW_tbGolosinas
AS
	SELECT	golo_ID, 
			golo_Nombre, 
			golo_Precio, 
			golo_Habilitado, 
			
			golo_Estado, 
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = golo_UsuarioCreador),
			golo_UsuarioCreador, 
			usr1.usua_Usuario AS golo_UsuarioCreador_Nombre,
			golo_FechaCreacion, 
			usr2.usua_Usuario AS golo_UsuarioModificador_Nombre,
			golo_UsuarioModificador, 
			golo_FechaModificacion
	FROM parq.tbGolosinas AS golo
	INNER JOIN acce.tbUsuarios AS usr1 ON golo.golo_UsuarioCreador = usr1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usr2 ON golo.golo_UsuarioModificador = usr2.usua_ID
GO

--*************** SELECT DE GOLOSINAS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbGolosinas_Select
AS
BEGIN
	SELECT * FROM parq.VW_tbGolosinas WHERE golo_Estado = 1 AND golo_Habilitado = 1
END
GO

--*************** FIND DE GOLOSINAS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_VWtbGolosinas_Find
	@golo_ID INT
AS
BEGIN
	SELECT * FROM parq.VW_tbGolosinas WHERE golo_ID = @golo_ID
END
GO

--*************** INSERT DE GOLOSINAS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbGolosinas_Insert
	@golo_Nombre			VARCHAR(300), 
	@golo_Precio			INT, 
	@golo_UsuarioCreador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS(SELECT * FROM parq.tbGolosinas WHERE golo_Nombre = @golo_Nombre)
				BEGIN
					SELECT 409 AS codeStatus, 'Este nombre de golosina ya existe' AS messageStatus					
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbGolosinas(golo_Nombre, golo_Precio, golo_UsuarioCreador)
					VALUES(@golo_Nombre, @golo_Precio, @golo_UsuarioCreador)

					SELECT 200 AS codeStatus, 'Golosina ingresada con éxito' AS messageStatus
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus			
	END CATCH
END
GO

--*************** UPDATE DE GOLOSINAS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbGolosinas_Update
@golo_ID						INT, 
@golo_Nombre					VARCHAR(300), 
@golo_Precio					INT, 
@golo_UsuarioModificador		INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT * FROM parq.tbGolosinas WHERE golo_Nombre = golo_Nombre AND golo_ID != @golo_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Este nombre de golosina ya existe' AS messageStatus					
				END
			ELSE
				BEGIN
					UPDATE parq.tbGolosinas
					SET golo_Nombre = @golo_Nombre, 
						golo_Precio = @golo_Precio, 
						golo_UsuarioModificador = @golo_UsuarioModificador, 
						golo_FechaModificacion = GETDATE()
					WHERE golo_ID = @golo_ID

					SELECT 200 AS codeStatus, 'Golosina actualizada exitosamente' AS messageStatus
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus			
	END CATCH
END
GO

--*************** DELETE DE GOLOSINAS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbGolosinas_Delete
	@golo_ID INT
AS
BEGIN
	BEGIN TRY 
		BEGIN TRANSACTION
			DECLARE @QuioscosOcupando INT = (SELECT COUNT(*) FROM parq.tbInsumosQuiosco WHERE golo_ID = @golo_ID)

			IF @QuioscosOcupando > 0
				BEGIN
					SELECT 409 AS codeStatus, 'La Golosina que desea eliminar se encuentra en uso' AS messageStatus					
				END
			ELSE
				BEGIN
					UPDATE parq.tbGolosinas
					SET golo_Estado = 0
					WHERE golo_ID = @golo_ID

					SELECT 200 AS codeStatus, 'Golosina eliminada con éxito' AS messageStatus
				END
		COMMIT
	END TRY 

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus		
	END CATCH
END
GO




------------------------------------------------------- //// PROCS PARA tbInsumosQuiosco -- ///// ----------------------------------------------------


--*************** VISTA DE INSUMOS QUIOSCO ******************--
CREATE OR ALTER VIEW parq.VW_tbInsumosQuiosco
AS
	SELECT  insu_ID, 
			insu.quio_ID, 
			quio.area_ID, 
			area.area_Nombre,


			quio_Nombre, 
			quio.empl_ID, 
			quio.regi_ID, 
			quio_ReferenciaUbicacion, 
			quio_Imagen, 
			

			insu.golo_ID, 
			golo_Nombre,
			golo_Precio,			
			insu_Stock, 

			insu_Habilitado, 
			insu_Estado, 
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = insu_UsuarioCreador),
			insu_UsuarioCreador, 
			usr1.usua_Usuario AS insu_UsuarioCreador_Nombre,
			insu_FechaCreacion, 
			insu_UsuarioModificador, 
			usr2.usua_Usuario AS insu_UsuarioModificador_Nombre,
			insu_FechaModificacion

	FROM parq.tbInsumosQuiosco AS insu
	INNER JOIN parq.tbQuioscos AS quio ON insu.quio_ID = quio.quio_ID
	INNER JOIN parq.tbGolosinas AS golo ON insu.golo_ID = golo.golo_ID
	INNER JOIN acce.tbUsuarios AS usr1 ON insu.insu_UsuarioCreador = usr1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usr2 ON insu.insu_UsuarioModificador = usr2.usua_ID
	INNER JOIN parq.tbAreas AS area ON quio.area_ID = area.area_ID
GO

--*************** SELECT DE INSUMOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbInsumosQuiosco_Select
AS
BEGIN
	SELECT * FROM parq.VW_tbInsumosQuiosco WHERE insu_Estado = 1 AND insu_Habilitado = 1
END
GO

--*************** FIND DE INSUMOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_VW_tbInsumosQuiosco_Find
	@insu_ID INT
AS
BEGIN
	SELECT * FROM parq.VW_tbInsumosQuiosco  WHERE insu_ID = @insu_ID
END
GO

--*************** INSERT DE INSUMOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbInsumosQuiosco_Insert
	@quio_ID				INT, 
	@golo_ID				INT, 
	@insu_Stock				INT, 
	@insu_UsuarioCreador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION			
			IF EXISTS (SELECT * FROM parq.tbInsumosQuiosco WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID)
				BEGIN
					UPDATE parq.tbInsumosQuiosco
					SET insu_Stock += @insu_Stock
					WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID

					SELECT 200 AS codeStatus, 'Cantidad exitosamente añadida al stock' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbInsumosQuiosco WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID AND insu_Estado = 0)
				BEGIN
					UPDATE parq.tbInsumosQuiosco
					SET	insu_Estado = 1,
						insu_Stock = @insu_Stock
					WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID

 					SELECT 200 AS codeStatus, 'Insumo añadido con éxito' AS messageStatus
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbInsumosQuiosco(quio_ID, golo_ID, insu_Stock, insu_UsuarioCreador)
					VALUES(@quio_ID, @golo_ID, @insu_Stock, @insu_UsuarioCreador)
					
					SELECT 200 AS codeStatus, 'Insumo añadido con éxito' AS messageStatus
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*************** DELETE DE INSUMOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbInsumosQuiosco_Delete
	@insu_ID INT
AS
BEGIN
	BEGIN TRY 
		BEGIN TRANSACTION
			UPDATE parq.tbInsumosQuiosco
			SET insu_Estado = 0
			WHERE insu_ID = @insu_ID
			SELECT 200 AS codeStatus, 'Insumo eliminado con éxito' AS messageStatus
		COMMIT
	END TRY

	BEGIN CATCH 
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus			
	END CATCH
END
GO




------------------------------------------------------- //// PROCS PARA tbRatings -- ///// ----------------------------------------------------


--*************** CREATE DE RATINGS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbRatings_Insert
	@atra_ID INT, 
	@clie_ID INT, 
	@rati_Estrellas INT, 
	@rati_Comentario VARCHAR(300),  
	@rati_UsuarioCreador INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT * FROM parq.tbRatings WHERE atra_ID = @atra_ID AND clie_ID = @clie_ID)
				BEGIN
					UPDATE parq.tbRatings
					SET rati_Estrellas = @rati_Estrellas,
						rati_Comentario = @rati_Comentario
					WHERE atra_ID = @atra_ID AND clie_ID = @clie_ID
					
					SELECT 200 AS codeStatus, 'Rating agregado con éxito!' AS messageStatus
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbRatings(atra_ID, clie_ID, rati_Estrellas, rati_Comentario, rati_UsuarioCreador)
					VALUES(@atra_ID, @clie_ID, @rati_Estrellas, @rati_Comentario, @rati_UsuarioCreador)

					SELECT 200 AS codeStatus, 'Rating agregado con éxito!' AS messageStatus
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus			
	END CATCH
END
GO



------------------------------------------------------- //// PROCS PARA tbVentasQuiosco -- ///// ----------------------------------------------------


--*************** VISTA DE VENTAS QUIOSCO ******************--
CREATE OR ALTER VIEW fact.VW_tbVentasQuiosco
AS
	SELECT	vent_ID, 
			vent.quio_ID, 
			quio_Nombre,
			area.area_Nombre, 
			regi_Nombre,
			quio_ReferenciaUbicacion, 
			quio_Imagen,

			vent.clie_ID,
			clie_Nombres,
			clie_Apellidos,
			CONCAT(clie_Nombres, ' ', clie_Apellidos) AS vent_ClienteNombreCompleto,
			clie_DNI,
			clie_Telefono,

			vent.pago_ID, 
			pago_Nombre,

			vent_Habilitado, 
			vent_Estado,
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = vent_UsuarioCreador), 
			vent_UsuarioCreador, 
			usr1.usua_Usuario AS vent_UsuarioCreador_Nombre,
			vent_FechaCreacion, 
			vent_UsuarioModificador, 
			usr2.usua_Usuario AS vent_UsuarioModificador_Nombre,
			vent_FechaModificacion
	FROM fact.tbVentasQuiosco AS vent
	INNER JOIN parq.tbQuioscos AS quio ON vent.quio_ID = quio.quio_ID
	INNER JOIN parq.tbClientes AS clie ON vent.clie_ID = clie.clie_ID
	INNER JOIN gral.tbMetodosPago AS pago ON vent.pago_ID = pago.pago_ID
	INNER JOIN parq.tbAreas AS area ON quio.area_ID = area.area_ID
	INNER JOIN parq.tbRegiones AS regi ON quio.regi_ID = regi.regi_ID
	INNER JOIN acce.tbUsuarios AS usr1 ON vent.vent_UsuarioCreador = usr1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usr2 ON vent.vent_UsuarioModificador = usr2.usua_ID
GO

--*************** CREATE DE VENTAS QUIOSCO ******************--
CREATE OR ALTER PROCEDURE UDP_tbVentasQuiosco_Insert
	@quio_ID					INT, 
	@clie_ID					INT, 
	@pago_ID					INT, 
	@vent_UsuarioCreador		INT
AS
BEGIN
	BEGIN TRY 
		BEGIN TRANSACTION
			INSERT INTO fact.tbVentasQuiosco(quio_ID, clie_ID, pago_ID, vent_UsuarioCreador)
			VALUES (@quio_ID, @clie_ID, @pago_ID, @vent_UsuarioCreador)
			
			SELECT 200 AS codeStatus, 'Factura creada con éxito' AS messageStatus
		COMMIT
	END TRY

	BEGIN CATCH 
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus			
	END CATCH
END
GO




------------------------------------------------------- //// PROCS PARA tbVentasQuioscoDetalle -- ///// ----------------------------------------------------


--*************** VISTA DE VENTAS QUIOSCO DETALLE******************--
CREATE OR ALTER VIEW fact.VW_tbVentasQuioscoDetalle
AS
	SELECT  deta_ID, 
			deta.vent_ID,
			deta.golo_ID,
			golo.golo_Nombre,
			golo.golo_Precio,						
			deta_Cantidad, 

			deta_Habilitado, 
			deta_Estado, 
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = deta_UsuarioCreador),
			deta_UsuarioCreador, 
			usr1.usua_Usuario AS deta_UsuarioCreador_Nombre,
			deta_FechaCreacion, 
			deta_UsuarioModificador, 
			usr2.usua_Usuario AS deta_UsuarioModificador_Nombre,
			deta_FechaModificacion

	FROM fact.tbVentasQuioscoDetalle AS deta
	INNER JOIN fact.tbVentasQuiosco AS vent ON deta.vent_ID = vent.vent_ID
	INNER JOIN parq.tbGolosinas AS golo ON deta.golo_ID = golo.golo_ID
	INNER JOIN acce.tbUsuarios AS usr1 ON deta.deta_UsuarioCreador = usr1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usr2 ON deta.deta_UsuarioModificador = usr2.usua_ID
GO

CREATE OR ALTER PROCEDURE fact.UDP_tbVentasQuioscoDetalle
@vent_ID					INT, 
@golo_ID					INT, 
@deta_Cantidad				INT, 
@deta_UsuarioCreador		INT
AS
BEGIN
	BEGIN TRY 
		BEGIN TRANSACTION
			INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, golo_ID, deta_Cantidad, deta_UsuarioCreador)
			VALUES (@vent_ID, @golo_ID, @deta_Cantidad, @deta_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Detalle añadido con éxito' AS messageStatus			
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus						
	END CATCH
END
GO
