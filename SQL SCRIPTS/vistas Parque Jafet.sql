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


CREATE OR ALTER VIEW acce.VW_Pantallas
AS
SELECT	pant_Id, 
		pant_Descripcion, 
		pant_Identificador, 
		pant_URL, 
		pant_Estado, 
		pant_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = pant_UsuarioCreador),
		pant_FechaCreacion, 
		pant_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = pant_UsuarioModificador), 
		pant_FechaModificacion
		FROM acce.tbPantallas

GO


CREATE OR ALTER VIEW acce.VW_Roles
AS
SELECT	role_Id, 
		role_Nombre, 
		role_Estado, 
		role_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = role_UsuarioCreador), 
		role_FechaCreacion, 
		role_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = role_UsuarioModificador), 
		role_FechaModificacion
		FROM acce.tbRoles

GO


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

--SELECT * FROM gral.VW_Departamentos
--SELECT * FROM gral.VW_Municipios
--SELECT * FROM gral.VW_EstadosCiviles
--SELECT * FROM gral.VW_MetodosPagos


--SELECT * FROM acce.VW_Usuarios
--SELECT * FROM acce.VW_Pantallas
--SELECT * FROM acce.VW_Roles