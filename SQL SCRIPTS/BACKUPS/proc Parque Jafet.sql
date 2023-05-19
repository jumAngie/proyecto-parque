--**********************************************************PROCEDIMIENTOS*********************************************************************--

USE dbParqueAtracciones
GO

--*****************************************************************GRAL************************************************************************--
--******************************************************/Tabla Estados Civiles*****************************************************************--
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

				SELECT 500 AS codeStatus, 'No puede Editar el Estado Civil, Ya existe esta Descripción' AS messageStatus

			END

			ELSE IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 1 AND civi_ID = @civi_ID)
			BEGIN

				SELECT 200 AS codeStatus, 'Estado Civil Modificado con éxito' AS messageStatus
			END

			ELSE IF EXISTS (SELECT * FROM gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion AND civi_Estado  = 0 )
			BEGIN
		
				SELECT 409 AS codeStatus, 'No puede Editar el Estado Civil, Ya existe esta Descripción pero se encuentra Eliminado' AS messageStatus
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
--*************************************************************/Tabla Estados Civiles*****************************************************************--

--------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************Tabla Departamentos********************************************************************--

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
            SELECT 409 AS codeStatus, 'El Nombre de Departamento ya está en uso' AS messageStatus
         END

	--si existe el Código
		 ELSE IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Codigo = @dept_Codigo AND dept_Estado  = 1)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Código de Departamento ya está en uso' AS messageStatus
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

			--validar Nombre y Código
			IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Nombre = @dept_Nombre AND dept_Codigo = @dept_Codigo AND dept_Estado = 1 AND dept_ID != @dept_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Departamento, Ya existe este Nombre y Código' AS messageStatus

			END
			--validar Nombre
			IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Nombre = @dept_Nombre AND dept_Estado = 1 AND dept_ID != @dept_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Departamento, Ya existe este Nombre' AS messageStatus

			END
			--validar codigo
			IF EXISTS (SELECT * FROM gral.VW_Departamentos WHERE dept_Codigo = @dept_Codigo AND dept_Estado  = 1 AND dept_ID != @dept_ID)
			BEGIN

				SELECT 500 AS codeStatus, 'No puede Editar el Departamento, Ya existe este Código' AS messageStatus

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


--************************************************************/Tabla Departamentos********************************************************************--

-------------------------------------------------------------------------------------------------------------------------------------------------

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
			SELECT 409 AS codeStatus, 'Ya existe un Municipio con este Nombre, pero está Eliminado' AS messageStatus
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
			SELECT 409 AS codeStatus, 'Ya existe un Municipio con este Nombre, pero está Eliminado' AS messageStatus
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
--************************************************************/Tabla Municipios****************************************************************--
--******************************************************************/GRAL********************************************************************--

-------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************ACCE************************************************************************--
--**************************************************************Tabla Roles********************************************************************--
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
	--si existe
		IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Nombre = @role_Nombre AND role_Estado  = 1)
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
--*************************************************************/Tabla Roles********************************************************************--
-------------------------------------------------------------------------------------------------------------------------------------------------

--*********************************************************Tabla Pantallas Por Rol**************************************************************--

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
	INSERT INTO [acce].[tbPantallasPorRol]
	(role_ID, pant_ID, ropa_UsuarioCreador)
	VALUES
	(@role_ID,@pant_ID,@ropa_UsuarioCreador)

	SELECT 200 AS codeStatus, 'Acceso Agregado con éxito' AS messageStatus

END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_DELETE
@role_ID INT,
@pant_ID INT,
@ropa_UsuarioCreador INT
AS
BEGIN
DELETE FROM  [acce].[tbPantallasPorRol]
WHERE role_ID=@role_ID AND pant_ID = @pant_ID

INSERT INTO [acce].[tbPantallasPorRol]
	(role_ID, pant_ID, ropa_UsuarioCreador)
	VALUES
	(@role_ID,@pant_ID,@ropa_UsuarioCreador)

	SELECT 200 AS codeStatus, 'Acceso Editado con éxito' AS messageStatus

END
GO

--********************************************************/Tabla Pantallas Por Rol**************************************************************--

-------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************Tabla Usuarios******************************************************************--
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_INDEX
AS
BEGIN
SELECT * FROM acce.VW_Usuarios
WHERE usua_Estado = 1
END

GO


CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_FIND 
@usua_ID					INT
AS
BEGIN
SELECT * FROM acce.VW_Usuarios
WHERE usua_ID = @usua_ID
END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_INSERT
@usua_Usuario			NVARCHAR(200),
@empl_ID					INT,
@usua_Clave			NVARCHAR(150),
@usua_Admin					BIT,
@role_ID					INT,
@usua_UsuarioCreador				INT
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


			INSERT INTO acce.tbUsuarios
			(usua_Usuario,empl_ID, usua_Clave, usua_Admin,role_ID,usua_UsuarioCreador)
			VALUES
			(@usua_Usuario,@empl_ID,@Encrypt,@usua_Admin,@role_ID,@usua_UsuarioCreador)

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
@usua_Usuario					NVARCHAR(MAX),
@usua_Clave					NVARCHAR(MAX)
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
	SELECT DISTINCT (pant_Descripcion),pant_IDentificador,pant_href
	FROM acce.tbPantallasPorRol T1
	INNER JOIN acce.tbPantallas T2
	ON T1.pant_ID = T2.pant_ID
	WHERE role_ID = ( SELECT role_ID FROM acce.tbUsuarios 
						WHERE usua_ID = @usua_ID)
						AND pant_Estado = 1
END
END

GO

--************************************************************/Tabla Usuarios******************************************************************--

--*****************************************************************/ACCE************************************************************************--
