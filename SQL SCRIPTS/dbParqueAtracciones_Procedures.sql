USE dbParqueAtracciones
GO



--*************************************************************Tabla Usuarios******************************************************************--
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


CREATE OR ALTER VIEW acce.VW_Pantallas
AS
SELECT	pant_Id, 
		pant_Descripcion, 
		pant_Identificador, 
		pant_URL, 
		pant_Estado,
		pant_Icono,
		pant_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = pant_UsuarioCreador),
		pant_FechaCreacion, 
		pant_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = pant_UsuarioModificador), 
		pant_FechaModificacion
		FROM acce.tbPantallas

GO


CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_INDEX
AS
BEGIN
SELECT * FROM acce.VW_Usuarios WHERE usua_Estado = 1
END
GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_FIND 
@usua_ID					INT
AS
BEGIN
SELECT * FROM acce.VW_Usuarios WHERE usua_ID = @usua_ID
END
GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_INSERT
@usua_Usuario				NVARCHAR(200),
@empl_ID					INT,
@usua_Clave					NVARCHAR(150),
@usua_Admin					BIT,
@role_ID					INT,
@usua_UsuarioCreador		INT
AS
BEGIN
	BEGIN TRY
	--si existe
		IF EXISTS (SELECT * FROM acce.tbUsuarios WHERE usua_Usuario = @usua_Usuario AND usua_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Nombre de Usuario ya existe' AS messageStatus
         END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM acce.tbUsuarios WHERE usua_Usuario = @usua_Usuario)
		 BEGIN
			
			DECLARE @Encrypt NVARCHAR(MAX) = (HASHBYTES('SHA2_512',@usua_Clave))


			INSERT INTO acce.tbUsuarios (usua_Usuario,empl_ID, usua_Clave, usua_Admin,role_ID,usua_UsuarioCreador)
			VALUES (@usua_Usuario,@empl_ID,@Encrypt,@usua_Admin,@role_ID,@usua_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Usuario Creado con éxito' AS messageStatus
		END
	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_UPDATE
@usua_ID					INT,
@empl_ID					INT,
@usua_Admin					BIT,
@role_ID					INT,
@usua_UsuarioModificador			INT
AS
BEGIN
	BEGIN TRY

			UPDATE acce.tbUsuarios
			SET
				empl_ID				=	@empl_ID,
				usua_Admin			=	@usua_Admin,
				role_ID				=	@role_ID,
				usua_UsuarioModificador	=	@usua_UsuarioModificador
				WHERE [usua_ID]		=	@usua_ID

			SELECT 200 AS codeStatus, 'Usuario Modificado con éxito' AS messageStatus

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_Pass
@usua_ID	INT,
@usua_Clave	NVARCHAR(MAX)
AS
BEGIN
BEGIN TRY
			DECLARE @Encrypt NVARCHAR(MAX) = (HASHBYTES('SHA2_512',@usua_Clave))
			UPDATE acce.tbUsuarios
			SET usua_Clave = @Encrypt
			WHERE usua_ID = @usua_ID

			SELECT 200 AS codeStatus, 'Contraseña Modificada con éxito' AS messageStatus

END TRY
BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
END CATCH
END

GO


CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_DELETE
@usua_ID					INT
AS
BEGIN
	BEGIN TRY
			UPDATE acce.tbUsuarios
			SET
				usua_Estado		=	0
				WHERE [usua_ID]	=	@usua_ID

			SELECT 200 AS codeStatus, 'Usuario Eliminado con éxito' AS messageStatus

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_LOGIN 
@usua_Usuario	NVARCHAR(MAX),
@usua_Clave		NVARCHAR(MAX)
AS
BEGIN

DECLARE @Encrypt NVARCHAR(MAX) = (HASHBYTES('SHA2_512',@usua_Clave))

	IF EXISTS (SELECT * FROM acce.VW_Usuarios WHERE usua_Usuario = @usua_Usuario AND usua_Clave = @Encrypt AND usua_Estado = 1)
	BEGIN
            SELECT * FROM acce.VW_Usuarios
			WHERE usua_Usuario = @usua_Usuario AND usua_Clave = @Encrypt
    END
	IF EXISTS (SELECT * FROM acce.VW_Usuarios WHERE usua_Usuario = @usua_Usuario AND usua_Clave = @Encrypt AND usua_Estado = 0)
	BEGIN
			SELECT	usua_ID = 0 ,
					usua_Usuario = 'Usuario No Valido'
	END
	IF NOT EXISTS (SELECT * FROM acce.VW_Usuarios WHERE usua_Usuario = @usua_Usuario AND usua_Clave = @Encrypt)
	BEGIN
			SELECT	usua_ID = 0 ,
					usua_Usuario = 'Usuario o Contraseña Incorrectos'
	END
END
GO


CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_MENU
@usua_ID INT
AS
BEGIN
DECLARE @Admin BIT = (	SELECT usua_Admin FROM acce.tbUsuarios 
						WHERE usua_ID = @usua_ID)
IF @Admin = 1
BEGIN
	SELECT * FROM acce.VW_Pantallas
	WHERE pant_Estado = 1
END
ELSE IF @Admin = 0
BEGIN
	SELECT DISTINCT (pant_Descripcion),pant_IDentificador,pant_URL
	FROM acce.tbRolesXPantallas T1
	INNER JOIN acce.tbPantallas T2
	ON T1.pant_ID = T2.pant_ID
	WHERE role_ID = ( SELECT role_ID FROM acce.tbUsuarios 
						WHERE usua_ID = @usua_ID)
						AND pant_Estado = 1
END
END

GO






-------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************ACCE************************************************************************--
--**************************************************************Tabla Roles********************************************************************--
CREATE OR ALTER VIEW acce.VW_Roles
AS
SELECT	role_Id, 
		role_Nombre, 
		role_Cantidad_Usuarios = (SELECT COUNT(*) FROM acce.tbUsuarios T2 WHERE T2.role_ID = T1.role_Id),
		role_Estado, 
		role_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = role_UsuarioCreador), 
		role_FechaCreacion, 
		role_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = role_UsuarioModificador), 
		role_FechaModificacion
		FROM acce.tbRoles T1

GO

CREATE OR ALTER PROC acce.UDP_tbRoles_INDEX
AS BEGIN

SELECT * FROM acce.VW_Roles
WHERE role_Estado = 1;

END
GO

CREATE OR ALTER PROC acce.UDP_tbRoles_FIND
@role_ID INT
AS BEGIN

SELECT * FROM acce.tbRoles 
WHERE role_ID = @role_ID;

END
GO

CREATE OR ALTER PROC acce.UDP_tbRoles_INSERT
@role_Nombre NVARCHAR(100),
@role_UsuarioCreador INT
AS BEGIN

	BEGIN TRY
	--si existe
		IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre AND role_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Rol ya existe' AS messageStatus
         END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre)
		 BEGIN
			


			INSERT INTO acce.tbRoles
			(role_Nombre, role_UsuarioCreador)
			VALUES
			(@role_Nombre, @role_UsuarioCreador)

			DECLARE @id INT= (SELECT CAST(IDENT_CURRENT('acce.tbRoles')AS INT))
			DECLARE @Rol NVARCHAR(MAX) = (SELECT role_Nombre FROM acce.tbRoles WHERE role_ID = @id)

			SELECT 200 AS codeStatus, 'Rol Creado con éxito' AS messageStatus
			UNION ALL
			SELECT @id,@Rol

		END

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO

CREATE OR ALTER PROC acce.UDP_tbRoles_UPDATE
@role_ID INT,
@role_Nombre NVARCHAR(100),
@role_UsuarioModificador INT
AS BEGIN

	BEGIN TRY
			--validar codigo
			IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre AND role_Estado  = 1 AND role_ID != @role_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Rol, Ya existe este Nombre' AS messageStatus

			END
			--validar si existe pero son los mismos datos
			ELSE IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre AND role_Estado  = 1 AND role_ID = @role_ID)
			BEGIN

				SELECT 200 AS codeStatus, 'Rol Modificado con éxito' AS messageStatus

			END
	--si existe
		ELSE IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre AND role_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Rol ya existe' AS messageStatus
         END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre)
		 BEGIN
			


	UPDATE acce.tbRoles
	SET role_Nombre	= @role_Nombre,
		role_UsuarioModificador	= @role_UsuarioModificador
		WHERE role_ID = @role_ID

			SELECT 200 AS codeStatus, 'Rol Modificado con éxito' AS messageStatus
		END

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO

CREATE OR ALTER PROC acce.UDP_tbRoles_DELETE
@role_ID INT
AS BEGIN

	BEGIN TRY
			UPDATE acce.tbRoles
			SET
				role_Estado		=	0
				WHERE role_ID	=	@role_ID

			SELECT 200 AS codeStatus, 'Rol Eliminado con éxito' AS messageStatus

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO



--*********************************************************Tabla Pantallas Por Rol**************************************************************--

CREATE OR ALTER PROC acce.UDP_tbPantallas_INDEX
AS BEGIN

SELECT * FROM acce.tbPantallas
WHERE pant_Estado = 1;

END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_CHECKED 
@role_ID INT
AS BEGIN
	SELECT Pant_ID FROM acce.tbRolesXPantallas
	WHERE role_ID = @role_ID
END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_INSERT
@role_ID INT,
@pant_ID INT,
@ropa_UsuarioCreador INT
AS
BEGIN
	INSERT INTO [acce].tbRolesXPantallas
	(role_ID, pant_ID, ropa_UsuarioCreador)
	VALUES
	(@role_ID,@pant_ID,@ropa_UsuarioCreador)

	SELECT 200 AS codeStatus, 'Acceso Agregado con éxito' AS messageStatus

END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_DELETE_TOTAL
@role_ID INT
AS
BEGIN
DELETE FROM  [acce].tbRolesXPantallas
WHERE role_ID = @role_ID 
	SELECT 200 AS codeStatus, 'Acceso Eliminado con éxito' AS messageStatus

END

GO
CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_DELETE
@role_ID INT,
@pant_ID INT,
@ropa_UsuarioModificador INT
AS
BEGIN
BEGIN TRY

INSERT INTO [acce].tbRolesXPantallas
	(role_ID, pant_ID, ropa_UsuarioCreador)
	VALUES
	(@role_ID,@pant_ID,@ropa_UsuarioModificador)

	SELECT 200 AS codeStatus, 'Acceso Editado con éxito' AS messageStatus
	END TRY
	BEGIN CATCH
	SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO



---------------------------------------------------------------- ESQUEMA GRAL ----------------------------------------------------------------
--******************************************************/Tabla Estados Civiles*****************************************************************--
CREATE OR ALTER VIEW gral.VW_EstadosCiviles
AS
SELECT	civi_Id, 
		civi_Descripcion, 
		civi_Estado, 
		civi_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = civi_UsuarioCreador),  
		civi_FechaCreacion, 
		civi_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = civi_UsuarioModificador),   
		civi_FechaModificacion
		FROM gral.tbEstadosCiviles


GO

CREATE OR ALTER PROC gral.UDP_tbEstadosCiviles_INDEX  
AS 
BEGIN

 SELECT * FROM gral.VW_EstadosCiviles
 WHERE civi_Estado = 1;

END

GO

CREATE OR ALTER PROC gral.UDP_tbEstadosCiviles_FIND   
@civi_ID INT
AS 
BEGIN

 SELECT * FROM gral.VW_EstadosCiviles
 WHERE civi_ID = @civi_ID;

END

GO

CREATE OR ALTER PROC gral.UDP_tbEstadosCiviles_INSERT 
@civi_Descripcion NVARCHAR(100),
@civi_UsuarioCreador INT
AS 
BEGIN

 	BEGIN TRY
		BEGIN TRANSACTION
	--si existe
		IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Estado Civil ya existe' AS messageStatus
         END
	--si existe y estado 0
		 ELSE IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 0)
			BEGIN

			DECLARE @ID INT = (SELECT civi_ID FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion) 

			UPDATE gral.tbEstadosCiviles
			SET
				civi_Estado				=	1
				WHERE civi_ID			=	@ID

			SELECT 200 AS codeStatus, 'Estado Civil creado con éxito' AS messageStatus

			END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM  gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion)
		 BEGIN
			
			INSERT INTO  gral.tbEstadosCiviles
			(civi_Descripcion, civi_UsuarioCreador)
			VALUES
			(@civi_Descripcion, @civi_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Estado Civil creado con éxito' AS messageStatus
		END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK 
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END

GO

CREATE OR ALTER PROC gral.UDP_tbEstadosCiviles_UPDATE 
@civi_ID INT,
@civi_Descripcion NVARCHAR(100),
@civi_UsuarioModificador INT
AS 
BEGIN

  	BEGIN TRY
		BEGIN TRANSACTION

			IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 1 AND civi_ID != @civi_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Estado Civil, Ya existe esta Descripci�n' AS messageStatus

			END

			ELSE IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 1 AND civi_ID = @civi_ID)
			BEGIN

				SELECT 200 AS codeStatus, 'Estado Civil Modificado con éxito' AS messageStatus
			END

			ELSE IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 0 )
			BEGIN
		
				SELECT 409 AS codeStatus, 'No puede Editar el Estado Civil, Ya existe esta Descripci�n pero se encuentra Eliminado' AS messageStatus
			END

			ELSE IF NOT EXISTS (SELECT * FROM  gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion)
			BEGIN
			UPDATE gral.tbEstadosCiviles
			SET
				civi_Descripcion		= @civi_Descripcion,
				civi_UsuarioModificador	= @civi_UsuarioModificador
				WHERE civi_ID			= @civi_ID

			SELECT 200 AS codeStatus, 'Estado Civil Modificado con éxito' AS messageStatus
			END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK 
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END

GO

CREATE OR ALTER PROC gral.UDP_tbEstadosCiviles_DELETE 
@civi_ID INT
AS 
BEGIN

  	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @Clientes INT =	(SELECT COUNT(*) FROM parq.tbEmpleados WHERE civi_ID = civi_ID)
			
			IF @Clientes > 0
			BEGIN
			SELECT 500 AS codeStatus, 'El Estado Civil que desea Eliminar esta en uso' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE gral.tbEstadosCiviles
			SET
				civi_Estado		=	0
				WHERE civi_ID	=	@civi_ID

			SELECT 200 AS codeStatus, 'Estado Civil Eliminado con éxito' AS messageStatus
			END

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK 
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END

GO




--*************************************************************Tabla Departamentos********************************************************************--
CREATE OR ALTER VIEW gral.VW_Departamentos
AS
SELECT	dept_Id,
		dept_Codigo,
		dept_Nombre, 
		dept_Estado, 
		dept_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = dept_UsuarioCreador),
		dept_FechaCreacion,
		dept_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = dept_UsuarioModificador), 
		dept_FechaModificacion
		FROM gral.tbDepartamentos

GO


CREATE OR ALTER VIEW gral.VW_Municipios
AS
SELECT	T1.dept_Id,
		T2.dept_Codigo,
		T2.dept_Nombre, 
		muni_Id,
		muni_Codigo, 
		muni_Nombre,
		muni_Estado, 
		muni_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = muni_UsuarioCreador), 
		muni_FechaCreacion, 
		muni_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = muni_UsuarioModificador),  
		muni_FechaModificacion
		FROM gral.tbMunicipios T1
		INNER JOIN gral.tbDepartamentos T2
		ON T1.dept_Id = T2.dept_Id
GO

CREATE OR ALTER PROC gral.UDP_tbDepartamentos_INDEX  
AS 
BEGIN

 SELECT * FROM gral.VW_Departamentos
 WHERE dept_Estado = 1;

END

GO

CREATE OR ALTER PROC gral.UDP_tbDepartamentos_FIND   
@dept_ID INT
AS 
BEGIN

 SELECT * FROM gral.VW_Departamentos
 WHERE dept_ID = @dept_ID;

END

GO

CREATE OR ALTER PROC gral.UDP_tbDepartamentos_INSERT 
@dept_Codigo			CHAR(2),
@dept_Nombre			NVARCHAR(100),
@dept_UsuarioCreador	INT
AS 
BEGIN

 	BEGIN TRY
	BEGIN TRANSACTION
	--si existe el nombre
		IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Nombre  = @dept_Nombre AND dept_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Nombre de Departamento ya est� en uso' AS messageStatus
         END

	--si existe el C�digo
		 ELSE IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Codigo = @dept_Codigo AND dept_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El C�digo de Departamento ya est� en uso' AS messageStatus
         END

	--si existe pero esta eliminado
		 ELSE IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Codigo = @dept_Codigo AND dept_Nombre = @dept_Nombre AND dept_Estado  = 0)
			BEGIN

			DECLARE @ID INT = (SELECT dept_ID FROM gral.VW_Departamentos WHERE dept_Codigo = @dept_Codigo AND dept_Nombre = @dept_Nombre AND dept_Estado  = 0) 

			UPDATE gral.tbDepartamentos
			SET
				dept_Estado				=	1
				WHERE dept_ID			=	@ID

			SELECT 200 AS codeStatus, 'Departamento Civil creado con éxito' AS messageStatus

			END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM  gral.tbEstadosCiviles WHERE civi_Descripcion = @dept_Nombre)
		 BEGIN
			
			INSERT INTO  gral.tbDepartamentos
			(dept_Codigo, dept_Nombre, dept_UsuarioCreador)
			VALUES
			(@dept_Codigo,@dept_Nombre,@dept_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Estado Civil creado con éxito' AS messageStatus
		END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

GO

CREATE OR ALTER PROC gral.UDP_tbDepartamentos_UPDATE 
@dept_ID					INT,
@dept_Codigo				CHAR(2),
@dept_Nombre				NVARCHAR(100),
@dept_UsuarioModificador	INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRANSACTION

			--validar Nombre y C�digo
			IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Nombre = @dept_Nombre AND dept_Codigo = @dept_Codigo AND dept_Estado = 1 AND dept_ID != @dept_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Departamento, Ya existe este Nombre y C�digo' AS messageStatus

			END
			--validar Nombre
			IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Nombre = @dept_Nombre AND dept_Estado = 1 AND dept_ID != @dept_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Departamento, Ya existe este Nombre' AS messageStatus

			END
			--validar codigo
			IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Codigo = @dept_Codigo AND dept_Estado  = 1 AND dept_ID != @dept_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Departamento, Ya existe este C�digo' AS messageStatus

			END
			--validar si existe pero son los mismos datos
			ELSE IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Nombre = @dept_Nombre AND  dept_Codigo = @dept_Codigo AND dept_Estado  = 1 AND dept_ID = @dept_ID)
			BEGIN

				SELECT 200 AS codeStatus, 'Departamento Modificado con éxito' AS messageStatus

			END
			--si existe pero esta eliminado
			ELSE IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE (dept_Nombre = @dept_Nombre OR dept_Codigo = @dept_Codigo) AND dept_Estado  = 0 )
			BEGIN
		
				SELECT 409 AS codeStatus, 'No puede editar este Departamento, Ya existe uno con datos Similares pero se encuentra Eliminado' AS messageStatus
			END

			ELSE IF NOT EXISTS (SELECT * FROM  gral.VW_Departamentos WHERE dept_Nombre = @dept_Nombre AND dept_Codigo = @dept_Codigo)
			BEGIN
			UPDATE gral.tbDepartamentos
			SET
				dept_Codigo				= @dept_Codigo,
				dept_Nombre				= @dept_Nombre,
				dept_UsuarioModificador	= @dept_UsuarioModificador
				WHERE dept_ID			= @dept_ID

			SELECT 200 AS codeStatus, 'Departamento Modificado con éxito' AS messageStatus
			END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END

GO

CREATE OR ALTER PROC gral.UDP_tbDepartamentos_DELETE 
@dept_ID INT
AS 
BEGIN
  	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @Municipios INT =	(SELECT COUNT(*) FROM gral.VW_Municipios WHERE dept_ID = @dept_ID)
			

			IF @Municipios > 0
			BEGIN
			SELECT 500 AS codeStatus, 'El Departamento que desea Eliminar esta en uso' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE gral.tbDepartamentos
			SET
				dept_Estado		=	0
				WHERE dept_ID	=	@dept_ID

			SELECT 200 AS codeStatus, 'Departamento Eliminado con éxito' AS messageStatus
			END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END

GO





--************************************************************Tabla Municipios********************************************************************--



CREATE OR ALTER PROC gral.UDP_tbMunicipios_INDEX  
AS
BEGIN
	SELECT * FROM gral.VW_Municipios
END

GO

CREATE OR ALTER PROC gral.UDP_tbMunicipios_FIND   
@muni_ID	INT
AS
BEGIN
	SELECT * FROM gral.VW_Municipios 
	WHERE muni_ID = @muni_ID
END

GO


CREATE OR ALTER PROC gral.UDP_tbMunicipios_FILTER 
@dept_ID INT
AS BEGIN

SELECT * FROM gral.VW_Municipios
WHERE dept_ID = @dept_ID

END

GO

CREATE OR ALTER PROC gral.UDP_tbMunicipios_INSERT 
@dept_ID				INT,
@muni_Nombre			NVARCHAR(200),
@muni_UsuarioCreador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		-- Si existe en un departamento
		IF EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'Ya existe un Municipio con este Nombre dentro de este Departamento' AS messageStatus
			COMMIT
			RETURN
		END

		-- Si existe en un departamento
		IF EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 0)
		BEGIN

			UPDATE gral.tbMunicipios
			SET muni_Estado = 1
			WHERE muni_Nombre = @muni_Nombre
			AND	  dept_ID = @dept_ID

			SELECT 200 AS codeStatus, 'Municipio Creado con éxito' AS messageStatus
			
			COMMIT
			RETURN
		END


		ELSE IF EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 0)
		BEGIN
			SELECT 409 AS codeStatus, 'Ya existe un Municipio con este Nombre, pero est� Eliminado' AS messageStatus
		END



		ELSE IF NOT EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 0)
		BEGIN

			DECLARE @depto CHAR(2) = (SELECT dept_Codigo FROM gral.VW_Departamentos WHERE dept_ID = @dept_ID)
			DECLARE @muni_num INT = CAST(RIGHT((SELECT TOP 1 muni_Codigo FROM gral.VW_Municipios WHERE dept_ID = @dept_ID ORDER BY muni_Codigo DESC), 2) AS INT)
			DECLARE @muni CHAR(2) = CAST((@muni_num + 1) AS CHAR(2))
			DECLARE @nuevo_muni CHAR(2) = (SELECT CASE WHEN LEN(@muni) < 2 THEN '0' + @muni ELSE @muni END)
			DECLARE @muni_Codigo CHAR(4) = @depto + @nuevo_muni 
			
			INSERT INTO gral.tbMunicipios
			(dept_ID, muni_Codigo, muni_Nombre,muni_UsuarioCreador)
			VALUES
			(@dept_ID,@muni_Codigo,@muni_Nombre,@muni_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Municipio Creado con éxito' AS messageStatus
		END

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
	END CATCH
END

GO

CREATE OR ALTER PROC gral.UDP_tbMunicipios_UPDATE 
@muni_ID					INT,
@dept_ID					INT,
@muni_Nombre				NVARCHAR(200),
@muni_UsuarioModificador	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		-- Si existe en un departamento
		IF EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 1 AND muni_ID!= @muni_ID)
		BEGIN
			SELECT 409 AS codeStatus, 'Ya existe un Municipio con este Nombre dentro de este Departamento' AS messageStatus
			COMMIT
			RETURN
		END

			IF EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 1 AND muni_ID = @muni_ID)
		BEGIN
			
			SELECT 200 AS codeStatus, 'yes Municipio Editado con éxito' AS messageStatus

			COMMIT
			RETURN
		END

		ELSE IF EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 0)
		BEGIN
			SELECT 409 AS codeStatus, 'Ya existe un Municipio con este Nombre, pero est� Eliminado' AS messageStatus
		END

		ELSE IF NOT EXISTS (SELECT * FROM gral.VW_Municipios WHERE dept_ID = @dept_ID AND muni_Nombre = @muni_Nombre AND muni_Estado = 0)
		BEGIN

			DECLARE @depto CHAR(2) = (SELECT dept_Codigo FROM gral.VW_Departamentos WHERE dept_ID = @dept_ID)
			DECLARE @muni_num INT = CAST(RIGHT((SELECT TOP 1 muni_Codigo FROM gral.VW_Municipios WHERE dept_ID = @dept_ID ORDER BY muni_Codigo DESC), 2) AS INT)
			DECLARE @muni CHAR(2) = CAST((@muni_num + 1) AS CHAR(2))
			DECLARE @nuevo_muni CHAR(2) = (SELECT CASE WHEN LEN(@muni) < 2 THEN '0' + @muni ELSE @muni END)
			DECLARE @muni_Codigo CHAR(4) = @depto + @nuevo_muni 
			
			UPDATE gral.tbMunicipios
			SET dept_ID					= @dept_ID,
				muni_Codigo				= @muni_Codigo,
				muni_Nombre				= @muni_Nombre,
				muni_UsuarioModificador = @muni_UsuarioModificador
				WHERE muni_ID			= @muni_ID

			SELECT 200 AS codeStatus, 'Municipio Editado con éxito' AS messageStatus
		END

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
	END CATCH
END

GO

CREATE OR ALTER PROC gral.UDP_tbMunicipios_DELETE 
@muni_ID	INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE gral.tbMunicipios
			SET   muni_Estado = 0
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
	END CATCH
END


GO





CREATE OR ALTER VIEW gral.VW_MetodosPagos
AS
SELECT	pago_ID, 
		pago_Nombre, 
		pago_Estado,
		pago_UsuarioCreador, 
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = pago_UsuarioCreador),
		pago_FechaCreacion, 
		pago_UsuarioModificador, 
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = pago_UsuarioModificador),         
		pago_FechaModificacion
		FROM gral.tbMetodosPago

GO





---------------------------------------------------------------- ESQUEMA PARQ ----------------------------------------------------------------

------------------------------------------------------- //// PROCS PARA tbCargos -- ///// ----------------------------------------------------


--*************** VISTA DE CARGOS ******************-
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

--*************** SELECT DE CARGOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_SELECT
AS
BEGIN
	SELECT *
  FROM [parq].VW_tbCargos
  WHERE carg_Estado = 1  AND carg_Habilitado = 1
END

--*************** FIND DE CARGOS ******************-
GO

--*************** FIND DE CARGOS ******************-
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



GO
--*************** INSERT DE CARGOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbCargos_INSERT
	@carg_Nombre			VARCHAR (300),
	@carg_UsuarioCreador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF(@carg_UsuarioCreador IS NULL OR @carg_UsuarioCreador  IS NULL OR @carg_UsuarioCreador = 0 OR @carg_UsuarioCreador = '')
				BEGIN
					SELECT 409 AS codeStatus, 'Los campos no pueden ser vacíos.' AS messageStatus
				END
			IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado  = 1 )
				 BEGIN
					SELECT 409 AS codeStatus, 'El nombre del cargo ya existe' AS messageStatus
				 END
			 ELSE IF EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_Estado  = 0)
				 BEGIN
				   UPDATE parq.tbCargos
						SET		carg_Estado = 1, carg_Habilitado = 1, carg_UsuarioModificador = @carg_UsuarioCreador
						WHERE	carg_Nombre = @carg_Nombre
					SELECT 200 AS codeStatus, 'Cargo creado con exito' AS messageStatus
				 END
			  ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre)
				BEGIN
					INSERT INTO parq.tbCargos	(carg_Nombre, carg_UsuarioCreador)
					VALUES						(@carg_Nombre, @carg_UsuarioCreador)
					
					SELECT SCOPE_IDENTITY()

					SELECT 200 AS codeStatus, 'Cargo creado con exito' AS messageStatus
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
EXECUTE parq.UDP_tbCargos_INSERT 'PRUEBA1', 1
EXECUTE parq.UDP_tbCargos_INSERT 'PRUEBA2', 1
GO

CREATE OR ALTER PROCEDURE gral.UDP_tbMetodosPago_List
AS
BEGIN
	SELECT * FROM gral.tbMetodosPago WHERE pago_Estado = 1
END
GO
--*************** UPDATE DE CARGOS ******************-
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

--*************** DELETE DE CARGOS ******************-
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
GO


------------------------------------------------------- //// PROCS PARA tbRegiones -- ///// ----------------------------------------------------
--*************** VISTA DE REGIONES ******************-
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

--*************** SELECT DE REGIONES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbRegiones_SELECT
AS
BEGIN
	SELECT  *
	FROM	parq.VW_tbRegiones
	WHERE regi_Estado = 1  AND regi_Habilitado = 1
END

--*************** FIND DE REGIONES ******************-
GO

--*************** FIND DE REGIONES ******************-
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
					SELECT 200 AS codeStatus, 'Regi�n creada con éxito' AS messageStatus
				 END
			  ELSE IF NOT EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre)
				BEGIN
					INSERT INTO parq.tbRegiones	(regi_Nombre, regi_UsuarioCreador)
					VALUES						(@regi_Nombre, @regi_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Regi�n creada con éxito' AS messageStatus
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

--*************** UPDATE DE REGIONES ******************-
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
				SELECT 200 AS codeStatus, 'Regi�n actualizada con éxito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbRegiones WHERE regi_Nombre = @regi_Nombre)
				BEGIN
					UPDATE parq.tbRegiones 
					SET regi_Nombre = @regi_UsuarioModificador, regi_UsuarioModificador = @regi_UsuarioModificador
					WHERE	regi_ID = @regi_ID
					SELECT 200 AS codeStatus, 'Regi�n actualizada con éxito' AS messageStatus
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

--*************** DELETE DE REGIONES ******************-
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
							SELECT 200 AS codeStatus, 'Regi�n eliminada con éxito' AS messageStatus
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

--*************** SELECT DE CLIENTES ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbClientes_SELECT
AS
BEGIN
	SELECT *
  FROM [parq].VW_tbClientes
  WHERE clie_Estado = 1  AND clie_Habilitado = 1
END

--*************** FIND DE CLIENTES ******************-
GO

--*************** FIND DE CLIENTES ******************--
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

--*************** UPDATE DE CLIENTES ******************--
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

--*************** DELETE DE CLIENTES ******************--
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

--*************** VISTA DE CLIENTES REGISTRADOS ******************--
CREATE OR ALTER VIEW parq.VW_tbClientesRegistrados
AS
SELECT [clre_ID]
      ,clire.clie_ID
	  ,clie.clie_Nombres + clie.clie_Apellidos AS clie_Nombres
      ,[clre_Usuario]
      ,[clre_Email]
      ,clre_Clave
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
  INNER JOIN parq.tbClientes clie ON clire.clie_ID = clie.clie_ID

--*************** SELECT DE CLIENTESREGISTRADOS ******************-
GO

--*************** SELECT DE CLIENTES REGISTRADOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbClientesRegistrados
	WHERE clre_Estado = 1  AND clre_Habilitado = 1
END

--*************** FIND DE CLIENTESREGISTRADOS ******************-
GO

--*************** FIND DE CLIENTES REGISTRADOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_FIND
@clre_Id INT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbClientesRegistrados
	WHERE clre_Estado = 1  
	AND	clre_ID = @clre_Id
END

GO

--*************** INSERT DE CLIENTES REGISTRADOS ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_INSERT
	@clie_ID				INT,
	@clre_Usuario			VARCHAR(300), 
	@clre_Email				NVARCHAR(300), 
	@clre_Clave				NVARCHAR(300), 
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

				DECLARE @CLAVE2 VARBINARY (MAX) = HASHBYTES('SHA2_512', @clre_Clave)
				DECLARE @INCRI2 VARCHAR(MAX) = CONVERT(VARCHAR(MAX), @CLAVE2 ,2)

				INSERT INTO parq.tbClientesRegistrados([clie_ID], [clre_Usuario],[clre_Email], clre_Clave, [clre_UsuarioCreador])
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

--*************** UPDATE DE CLIENTES REGISTRADOS ******************--
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

--*************** DELETE DE CLIENTES REGISTRADOS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbClientesRegistrados_DELETE
	@clre_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN 
				UPDATE parq.tbClientesRegistrados
				SET		clre_Estado	=	0
				WHERE   clre_ID	= @clre_ID
				SELECT 200 AS codeStatus, 'Cliente eliminado con éxito' AS messageStatus	
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO




------------------------------------------------------- //// PROCS PARA tbAreas -- ///// ----------------------------------------------------


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

--*************** SELECT DE AREAS ******************--
CREATE OR ALTER PROCEDURE parq.UDP_tbAreas_SELECT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbAreas
	WHERE area_Estado = 1  AND area_Habilitado = 1
END

--*************** FIND DE AREAS ******************-
GO

--*************** FIND DE AREAS ******************--
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

--*************** UPDATE DE AREAS ******************--
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
				DECLARE @AtraccionesOcupa INT = (SELECT COUNT(*) FROM parq.tbAtracciones WHERE area_ID = @area_ID)
				DECLARE @RegionesEnUso INT = @QuioscosOcupa + @AtraccionesOcupa

				IF	@RegionesEnUso > 0
					BEGIN
						SELECT 500 AS codeStatus, 'El area que desea eliminar est� en uso.' AS messageStatus
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
						SELECT 500 AS codeStatus, 'El Ticket que desea eliminar est� en uso.' AS messageStatus
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
      ,tcli.tckt_ID
	  ,tick.tckt_Nombre
      ,tcli.clie_ID
	  , clie.clie_Nombres + ' ' + clie.clie_Apellidos AS clie_Nombres
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
  INNER JOIN parq.tbTickets tick ON tcli.tckt_ID = tick.tckt_ID
  INNER JOIN parq.tbClientes clie ON tcli.clie_ID = clie.clie_ID

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
CREATE OR ALTER PROCEDURE parq.UDP_tbTicketClientes_UPDATE
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
CREATE OR ALTER PROCEDURE parq.UDP_tbTicketClientes_DELETE
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
						SELECT 500 AS codeStatus, 'El Ticket Detalle que desea eliminar est� en uso.' AS messageStatus
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
	SELECT	atra.area_ID, 
			area_Nombre, 
			area_Descripcion, 
			(SELECT regi_Nombre FROM parq.tbRegiones WHERE regi_ID = area.regi_ID) AS area_regi_Nombre,
			area_UbicaionReferencia, 
			area_Imagen,

			atra_ID, 
			atra_Nombre, 
			atra_Descripcion, 
			atra.regi_ID,
			(SELECT regi_Nombre FROM parq.tbRegiones WHERE regi_ID = atra.regi_ID) AS atra_regi_Nombre,
			atra_ReferenciaUbicacion, 
			atra_LimitePersonas, 
			atra_DuracionRonda, 
			atra_Imagen, 
			atra_Habilitado, 
			atra_Estado, 

			atra_UsuarioCreador, 
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = atra_UsuarioCreador),
			(SELECT usua_Usuario FROM acce.tbUsuarios WHERE usua_ID = atra.atra_UsuarioCreador) AS atra_UsuarioCreador_Nombre,
			atra_FechaCreacion, 
			
			atra_UsuarioModificador, 
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = atra_UsuarioModificador),
			(SELECT usua_Usuario FROM acce.tbUsuarios WHERE usua_ID = atra.atra_UsuarioModificador) AS atra_UsuarioModificador_Nombre,
			atra_FechaModificacion	
	
	FROM [parq].[tbAtracciones] AS atra 
	INNER JOIN parq.tbAreas AS area ON atra.area_ID = area.area_ID
GO



--*************** SELECT DE ATRACCIONES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_SELECT
AS
BEGIN
	SELECT * FROM parq.VW_tbAtracciones WHERE atra_Estado = 1
END
GO

CREATE OR ALTER PROC parq.UDP_tbAtracciones_AtraccionesPorAreaId
	@area_ID		INT
AS
BEGIN
		SELECT * FROM parq.VW_tbAtracciones
		WHERE	 area_ID = @area_ID
END
GO

--*************** FIND DE ATRACCIONES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_FIND
	@atra_ID INT
AS
BEGIN
	SELECT *
	FROM [parq].VW_tbAtracciones
	WHERE atra_Estado = 1 AND atra_ID = @atra_ID
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
	@atra_DuracionRonda			INT, 
	@atra_Imagen				NVARCHAR(MAX),
	@atra_UsuarioCreador		INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM parq.tbAtracciones WHERE atra_Nombre = @atra_Nombre)
				BEGIN
					SELECT 409 AS codeStatus, 'Ya existe una atracción con este nombre' AS messageStatus					
				END
			ELSE 
				BEGIN
					INSERT INTO parq.tbAtracciones(area_ID, atra_Nombre, atra_Descripcion, regi_ID, atra_ReferenciaUbicacion, atra_LimitePersonas, atra_DuracionRonda, atra_Imagen, atra_UsuarioCreador)
					VALUES						 (@area_ID, @atra_Nombre, @atra_Descripcion, @regi_ID, @atra_ReferenciaUbicacion, @atra_LimitePersonas, @atra_DuracionRonda, @atra_Imagen, @atra_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Atracción creada con éxito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*************** UPDATE DE ATRACCIONES ******************-
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_UPDATE
	@atra_ID					INT,
	@area_ID					INT, 
	@atra_Nombre				VARCHAR(300), 
	@atra_Descripcion			VARCHAR(300), 
	@regi_ID					INT, 
	@atra_ReferenciaUbicacion	VARCHAR(300), 
	@atra_LimitePersonas		INT, 
	@atra_DuracionRonda			INT, 
	@atra_Imagen				NVARCHAR(MAX),
	@atra_UsuarioModificador	INT
 AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (SELECT * FROM parq.tbAtracciones WHERE  atra_Nombre = @atra_Nombre AND atra_ID != @atra_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Ya existe una atracción con este nombre' AS messageStatus
				END
			ELSE 
				BEGIN
					UPDATE parq.tbAtracciones
					SET		area_ID =	@area_ID, 
							atra_Nombre = @atra_Nombre,
							regi_ID = @regi_ID,
							atra_ReferenciaUbicacion = @atra_ReferenciaUbicacion,
							atra_LimitePersonas = @atra_LimitePersonas,
							atra_DuracionRonda = @atra_DuracionRonda,
							atra_Imagen = @atra_Imagen,
							atra_UsuarioModificador = @atra_UsuarioModificador,
							atra_FechaModificacion = GETDATE()
					WHERE	atra_ID   =		@atra_ID
					SELECT 200 AS codeStatus, 'Atracción actualizada con éxito' AS messageStatus
				END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*************** DELETE DE ATRACCIONES ******************-
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
						SELECT 409 AS codeStatus, 'La Atracción que desea eliminar está en uso.' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.tbAtracciones
							SET atra_Estado	= 0 WHERE atra_ID =	@atra_ID
						SELECT 200 AS codeStatus, 'Atracción eliminada con éxito' AS messageStatus
					END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO



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
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = empl_UsuarioModificador),
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
					SELECT 409 AS codeStatus, 'Este Tel�fono ya existe' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_Email = @empl_Email)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Correo Electr�nico ya existe' AS messageStatus
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
					SELECT 409 AS codeStatus, 'Este Tel�fono ya existe' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbEmpleados WHERE empl_Email = @empl_Email AND empl_ID != @empl_ID)
				BEGIN
					SELECT 409 AS codeStatus, 'Este Correo Electr�nico ya existe' AS messageStatus
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
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = quio_UsuarioModificador),
			
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
CREATE OR ALTER PROCEDURE parq.UDP_tbQuioscos_Insert --1, 'MiniShop', 2, 1, 'A media cuadra de la monta�a rusa', '', 1
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
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = golo_UsuarioModificador),
			
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
			IF EXISTS (SELECT * FROM parq.tbGolosinas WHERE golo_Nombre = @golo_Nombre AND golo_ID != @golo_ID)
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
			quio_Nombre, 
			quio.area_ID,
			(SELECT area_Nombre FROM parq.tbAreas WHERE area_ID = quio.area_ID) AS quio_area_Nombre, 		
			quio.empl_ID,
			(SELECT CONCAT(empl_PrimerNombre, ' ', empl_SegundoNombre, ' ', empl_PrimerApellido, ' ', empl_SegundoApellido) FROM parq.tbEmpleados WHERE empl_ID = quio.empl_ID) AS quio_empl_NombreCompleto,
			quio.regi_ID,
			(SELECT regi_Nombre FROM parq.tbRegiones WHERE regi_ID = quio.regi_ID) AS quio_regi_Nombre, 
			quio_ReferenciaUbicacion, 
			quio_Imagen, 

			insu.golo_ID, 
			golo_Nombre,
			golo_Precio,			
			insu_Stock, 

			insu_Habilitado, 
			insu_Estado, 
			
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = insu_UsuarioCreador),
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = insu_UsuarioModificador),
			
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
	INNER JOIN parq.tbEmpleados AS empl ON quio.empl_ID = empl.empl_ID
	INNER JOIN parq.tbRegiones AS regi ON quio.regi_ID = regi.regi_ID
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


CREATE OR ALTER PROCEDURE parq.UDP_VW_tbInsumosQuiosco_SelectGolosinasByQuiosco
	@quio_ID INT
AS
BEGIN
	SELECT * FROM parq.VW_tbInsumosQuiosco WHERE quio_ID = @quio_ID
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

					SELECT 200 AS codeStatus, 'Cantidad exitosamente a�adida al stock' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbInsumosQuiosco WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID AND insu_Estado = 0)
				BEGIN
					UPDATE parq.tbInsumosQuiosco
					SET	insu_Estado = 1,
						insu_Stock = @insu_Stock
					WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID

 					SELECT 200 AS codeStatus, 'Insumo a�adido con éxito' AS messageStatus
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbInsumosQuiosco(quio_ID, golo_ID, insu_Stock, insu_UsuarioCreador)
					VALUES(@quio_ID, @golo_ID, @insu_Stock, @insu_UsuarioCreador)
					
					SELECT 200 AS codeStatus, 'Insumo a�adido con éxito' AS messageStatus
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
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = vent_UsuarioModificador),
			
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

--*************** SELECT DE VENTAS QUIOSCO ******************--
CREATE OR ALTER PROCEDURE fact.UDP_VW_tbVentasQuiosco_Select
AS
BEGIN
	SELECT * FROM fact.VW_tbVentasQuiosco WHERE vent_Estado = 1
END
GO


CREATE OR ALTER PROCEDURE fact.UDP_VW_tbVentasQuiosco_Find
	@vent_ID INT
AS
BEGIN
	SELECT * FROM fact.VW_tbVentasQuiosco WHERE vent_ID = @vent_ID
END
GO

--*************** CREATE DE VENTAS QUIOSCO ******************--
CREATE OR ALTER PROCEDURE fact.UDP_tbVentasQuiosco_Insert
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
			DECLARE @CurrentID INT = (SELECT SCOPE_IDENTITY())
			SELECT 200 AS codeStatus, @CurrentID AS messageStatus
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
			deta.insu_ID,
			golo.golo_Nombre,
			golo.golo_Precio,						
			deta_Cantidad, 

			deta_Habilitado, 
			deta_Estado, 
			
			empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = deta_UsuarioCreador),
			empl_modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = deta_UsuarioModificador),
			
			deta_UsuarioCreador, 
			usr1.usua_Usuario AS deta_UsuarioCreador_Nombre,
			deta_FechaCreacion, 
			deta_UsuarioModificador, 
			usr2.usua_Usuario AS deta_UsuarioModificador_Nombre,
			deta_FechaModificacion

	FROM fact.tbVentasQuioscoDetalle AS deta
	INNER JOIN fact.tbVentasQuiosco AS vent ON deta.vent_ID = vent.vent_ID
	INNER JOIN parq.tbGolosinas AS golo ON deta.insu_ID = golo.golo_ID
	INNER JOIN acce.tbUsuarios AS usr1 ON deta.deta_UsuarioCreador = usr1.usua_ID
	LEFT JOIN acce.tbUsuarios AS usr2 ON deta.deta_UsuarioModificador = usr2.usua_ID
GO

--*************** SELECT DE VENTAS QUIOSCO DETALLE******************--
CREATE OR ALTER PROCEDURE fact.UDP_VW_tbVentasQuioscoDetalle_Select
AS
BEGIN
	SELECT * FROM fact.VW_tbVentasQuioscoDetalle WHERE deta_Estado = 1
END
GO


CREATE OR ALTER PROCEDURE fact.UDP_VW_VentasQuioscoDetalle_DetalleByVenta
	@vent_ID INT
AS
BEGIN 
	SELECT * FROM fact.VW_tbVentasQuioscoDetalle WHERE vent_ID = @vent_ID
END
GO

SELECT * FROM fact.tbVentasQuiosco

SELECT * FROM fact.VW_tbVentasQuiosco WHERE vent_ID = 5
SELECT * FROM FACT.VW_tbVentasQuioscoDetalle WHERE vent_ID = 5

SELECT * FROM parq.VW_tbInsumosQuiosco WHERE quio_ID = 1
GO


--*************** CREATE DE VENTAS QUIOSCO DETALLE******************--
CREATE OR ALTER PROCEDURE fact.UDP_tbVentasQuioscoDetalle_Insert 
@vent_ID					INT,
@insu_ID					INT,
@deta_Cantidad				INT,
@deta_UsuarioCreador		INT
AS
BEGIN
	BEGIN TRY 
		BEGIN TRANSACTION
			DECLARE @quio_ID INT = (SELECT quio_ID FROM fact.tbVentasQuiosco WHERE vent_ID = @vent_ID)
			DECLARE @StockInsumoActual INT = (SELECT insu_Stock FROM parq.tbInsumosQuiosco WHERE quio_ID = @quio_ID AND insu_ID = @insu_ID)
					

			IF EXISTS (SELECT * FROM fact.tbVentasQuioscoDetalle WHERE insu_ID = @insu_ID AND vent_ID = @vent_ID )
				BEGIN
					IF @deta_Cantidad > @StockInsumoActual
						BEGIN
							SELECT 409 AS codeStatus, CONCAT('Cantidad excede el stock disponible. Stock actual:', ' ', @StockInsumoActual) AS messageStatus						
						END
					ELSE 
						BEGIN
							UPDATE fact.tbVentasQuioscoDetalle 
							SET deta_Cantidad += @deta_Cantidad
							WHERE insu_ID = @insu_ID AND vent_ID = @vent_ID

							UPDATE parq.tbInsumosQuiosco
							SET insu_Stock -= @deta_Cantidad 
							WHERE insu_ID = @insu_ID AND quio_ID = @quio_ID

							DECLARE @insu_Nombre VARCHAR(100) = (SELECT golo_Nombre FROM fact.VW_tbVentasQuioscoDetalle WHERE insu_ID = @insu_ID AND vent_ID = @vent_ID)

							SELECT 200 AS codeStatus, CONCAT('Cantidad añadida exitosamente al insumo:', ' ', @insu_Nombre) AS messageStatus	
						END
				END
			ELSE
				BEGIN
					IF @deta_Cantidad > @StockInsumoActual
						BEGIN
							SELECT 409 AS codeStatus, CONCAT('Cantidad excede el stock disponible. Stock actual:', ' ', @StockInsumoActual) AS messageStatus										
						END
					ELSE
						BEGIN
							INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
							VALUES (@vent_ID, @insu_ID, @deta_Cantidad, @deta_UsuarioCreador)

							UPDATE parq.tbInsumosQuiosco
							SET insu_Stock -= @deta_Cantidad 
							WHERE insu_ID = @insu_ID AND quio_ID = @quio_ID

							SELECT 200 AS codeStatus, 'Insumo añadido con éxito' AS messageStatus
						END				
				END
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus						
	END CATCH
END
GO



CREATE OR ALTER PROCEDURE fact.UDP_tbVentasQuioscoDetalle_DeleteInsumo
	@vent_ID INT,
	@deta_ID INT,
	@deta_Cantidad INT,
	@insu_ID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @quio_ID INT = (SELECT quio_ID FROM fact.tbVentasQuiosco WHERE vent_ID = @vent_ID) 
			DECLARE @StockInsumoActual INT = (SELECT insu_Stock FROM parq.tbInsumosQuiosco WHERE insu_ID = @insu_ID AND quio_ID = @quio_ID)

			UPDATE parq.tbInsumosQuiosco
			SET insu_Stock += @deta_Cantidad
			WHERE insu_ID = @insu_ID AND quio_ID = @quio_ID

			DELETE FROM fact.tbVentasQuioscoDetalle
			WHERE deta_ID = @deta_ID

			SELECT 200 AS codeStatus, 'Insumo eliminado exitosamente' AS messageStatus						

		COMMIT
	END TRY
	BEGIN CATCH 
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus						 
	END CATCH 
END
GO

SELECT * FROM fila.tbHistorialVisitantesAtraccion
GO

CREATE OR ALTER VIEW fila.VW_tbHistorialVisitantesAtraccion
AS
SELECT	hiat_ID, 
		hist.atra_ID, 
		atra.atra_Nombre,
		ticl_ID, 
		viat_HoraEntrada, 
		hiat_FechaFiltro, 
		hiat_Habilitado, 
		hiat_Estado, 
		hiat_UsuarioCreador, 
		hiat_FechaCreacion, 
		hiat_UsuarioModificador, 
		hiat_FechaModificacion 

FROM fila.tbHistorialVisitantesAtraccion AS hist
INNER JOIN parq.tbAtracciones AS atra ON hist.atra_ID = atra.atra_ID
GO

CREATE OR ALTER PROCEDURE fila.UDP_VW_tbHistorialVisitantesAtraccion_GraphicData
	@hist_FechaFiltro DATE
AS
	BEGIN
		IF @hist_FechaFiltro IS NULL OR @hist_FechaFiltro = ''
			BEGIN
				SELECT TOP(5) atra_ID , COUNT(ticl_ID)  AS ticl_ID FROM fila.VW_tbHistorialVisitantesAtraccion
				GROUP BY atra_ID
				ORDER BY ticl_ID DESC				
			END
		ELSE 
			BEGIN
				SELECT TOP(5) atra_ID , COUNT(ticl_ID)  AS ticl_ID FROM fila.VW_tbHistorialVisitantesAtraccion WHERE hiat_FechaFiltro = @hist_FechaFiltro
				GROUP BY atra_ID
				ORDER BY ticl_ID DESC
			END
	END
GO












EXECUTE acce.UDP_tbUsuarios_INSERT 'Admin', 1, 'Admin123', 1, NULL, 1
EXECUTE acce.UDP_tbUsuarios_LOGIN 'Admin', 'Admin123'




SET IDENTITY_INSERT [acce].[tbPantallas] ON 
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (1, N'Usuarios', N'/usuarios', N'', N'', N'ACCE', N'bi bi-circle', 1, 1, CAST(N'2023-05-24T15:14:37.347' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (2, N'Roles', N'/roles', NULL, NULL, N'ACCE', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T08:16:45.200' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (3, N'Golosinas', N'/listgolosinas', NULL, NULL, N'QUIO', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T08:21:30.043' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (4, N'Quioscos', N'/quioscos-listado', NULL, NULL, N'QUIO', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T11:10:30.873' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (5, N'Facturación Quiosco', N'/ventasquiosco-listado', NULL, NULL, N'QUIO', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T11:28:15.537' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (6, N'Atracciones', N'/atracciones-listado', NULL, NULL, N'PARQ', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T11:31:21.063' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (7, N'Empleados', N'/listempleados', NULL, NULL, N'PARQ', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T11:34:48.790' AS DateTime), NULL, NULL)
GO
INSERT [acce].[tbPantallas] ([pant_ID], [pant_Descripcion], [pant_URL], [pant_Menu], [pant_HtmlID], [pant_Identificador], [pant_Icono], [pant_Estado], [pant_UsuarioCreador], [pant_FechaCreacion], [pant_UsuarioModificador], [pant_FechaModificacion]) VALUES (8, N'Clientes', N'/clientes', NULL, NULL, N'PARQ', N'bi bi-circle', 1, 1, CAST(N'2023-05-30T11:42:17.247' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [acce].[tbPantallas] OFF
GO

