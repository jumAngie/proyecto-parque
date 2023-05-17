CREATE DATABASE dbParqueAtracciones
GO

USE dbParqueAtracciones
GO
CREATE SCHEMA gral
GO
CREATE SCHEMA parq
GO
CREATE SCHEMA acce
GO
CREATE SCHEMA fact
GO



/*TABLAS ESQUEMA GRAL*/

--CREACION DE TABLA tbEstadosCiviles
CREATE TABLE gral.tbEstadosCiviles(
	civi_ID					INT IDENTITY(1,1),
	civi_Descripcion		VARCHAR(200),
	civi_Estado				INT DEFAULT 1,
	civi_UsuarioCreador		INT DEFAULT 1,
	civi_FechaCreacion		DATETIME DEFAULT GETDATE(),
	civi_UsuarioModificador	INT,
	civi_FechaModificacion	DATETIME,
	CONSTRAINT PK_gral_tbEstadosCiviles_civi_ID PRIMARY KEY (civi_ID),
	CONSTRAINT UQ_gral_tbEstadosCiviles_civi_Descripcion UNIQUE (civi_Descripcion),
)
GO

--CREACION DE TABLA tbDepartamentos
CREATE TABLE gral.tbDepartamentos(
	dept_ID						INT IDENTITY(1,1),
	dept_Codigo					CHAR(2),
	dept_Nombre					NVARCHAR(200),
	dept_Estado					INT DEFAULT (1),
	dept_UsuarioCreador			INT DEFAULT 1,
	dept_FechaCreacion			DATETIME DEFAULT GETDATE(),
	dept_UsuarioModificador		INT,
	dept_FechaModificacion		DATETIME,	
	
	CONSTRAINT PK_gral_tbDepartamentos_dept_ID PRIMARY KEY (dept_ID),
	CONSTRAINT UQ_gral_tbDepartamentos_dept_Codigo UNIQUE (dept_Codigo),
	CONSTRAINT UQ_gral_tbDepartamentos_dept_Nombre UNIQUE (dept_Nombre),
)
GO

--CREACION DE TABLA tbMunicipios
CREATE TABLE gral.tbMunicipios(
	muni_ID						INT IDENTITY(1,1),
	dept_ID						INT,
	muni_Codigo					CHAR(4),
	muni_Nombre					NVARCHAR(200),
	muni_Estado					INT DEFAULT 1,
	muni_UsuarioCreador			INT DEFAULT 1,
	muni_FechaCreacion			DATETIME DEFAULT GETDATE(),
	muni_UsuarioModificador		INT,
	muni_FechaModificacion		DATETIME,
	CONSTRAINT PK_gral_tbMunicipios_muni_ID PRIMARY KEY (muni_ID),
	CONSTRAINT FK_gral_tbMunicipios_tbDepartamentos_dept_ID FOREIGN KEY(dept_ID) REFERENCES gral.tbDepartamentos (dept_ID),
	CONSTRAINT UQ_gral_tbMunicipios_muni_Codigo UNIQUE (muni_Codigo),

)
GO

--CREACION DE TABLA tbMetodosPago
CREATE TABLE gral.tbMetodosPago(
	pago_ID						INT IDENTITY(1,1),
	pago_Nombre					NVARCHAR (200),
	pago_Estado					INT DEFAULT 1,
	pago_UsuarioCreador			INT DEFAULT 1,
	pago_FechaCreacion			DATETIME DEFAULT GETDATE(),
	pago_UsuarioModificador		INT,
	pago_FechaModificacion		DATETIME,

	CONSTRAINT PK_gral_tbMetodosPago_pago_ID PRIMARY KEY (pago_ID),
	CONSTRAINT UQ_gral_tbMetodosPago_pago_Nombre UNIQUE (pago_Nombre),
)
GO




/*TABLAS ESQUEMA ACCE*/

--CREACION DE TABLA tbRoles
CREATE TABLE acce.tbRoles(
	role_ID						INT IDENTITY(1,1),
	role_Nombre					VARCHAR(250),
	role_Estado					INT DEFAULT 1,
	role_UsuarioCreador			INT DEFAULT 1,
	role_FechaCreacion			DATETIME DEFAULT GETDATE(),
	role_UsuarioModificador		INT,
	role_FechaModificacion		DATETIME,

	CONSTRAINT PK_acce_tbRoles_role_ID PRIMARY KEY (role_ID),
	CONSTRAINT UQ_acce_tbRoles_role_Nombre UNIQUE (role_Nombre),
)
GO

--CREACION DE TABLA tbPantallas
CREATE TABLE acce.tbPantallas(
	pant_ID						INT IDENTITY(1,1),
	pant_Descripcion			VARCHAR (250),
	pant_URL					NVARCHAR(300),
	pant_Menu					NVARCHAR(300),
	pant_HtmlID					NVARCHAR(300),
	pant_Identificador			NVARCHAR(100),
	pant_Icono					NVARCHAR(100),
	pant_Estado					INT DEFAULT 1,
	pant_UsuarioCreador			INT DEFAULT	1,
	pant_FechaCreacion			DATETIME DEFAULT GETDATE(),
	pant_UsuarioModificador		INT,
	pant_FechaModificacion		DATETIME,

	CONSTRAINT PK_acce_tbPantallas_pant_ID	PRIMARY KEY (pant_ID),
)
GO

--CREACION DE TABLA tbRolesXPantallas
CREATE TABLE acce.tbRolesXPantallas(
	ropa_ID						INT IDENTITY(1,1),
	role_ID						INT,
	pant_ID						INT,
	ropa_Estado					INT DEFAULT 1,
	ropa_UsuarioCreador			INT DEFAULT 1,
	ropa_FechaCreacion			DATETIME DEFAULT GETDATE(),
	ropa_UsuarioModificador		INT,
	ropa_FechaModificacion		DATETIME,

	CONSTRAINT PK_acce_tbRolesXPantallas_ropa_ID PRIMARY KEY (ropa_ID),
	CONSTRAINT FK_acce_tbRolesXPantallas_tbRoles_role_ID FOREIGN KEY (role_ID) REFERENCES acce.tbRoles (role_ID),
	CONSTRAINT FK_acce_tbRolesXPantallas_tbPantallas_pant_ID FOREIGN KEY (pant_ID) REFERENCES acce.tbPantallas (pant_ID),
)
GO

--------> CREACION DE TABLA tbUsuarios
CREATE TABLE acce.tbUsuarios( 
	usua_ID						INT IDENTITY(1,1), 
	usua_Usuario				NVARCHAR(100), 
	usua_Clave					VARCHAR(MAX),
	empl_ID						INT,
	role_ID                     INT,
	usua_Img					NVARCHAR(MAX),
	usua_Estado					INT DEFAULT 1,
	usua_UsuarioCreador			INT,
	usua_FechaCreacion			DATETIME DEFAULT GETDATE(),
	usua_UsuarioModificador		INT,
	usua_FechaModificacion		DATETIME,

	CONSTRAINT PK_acce_tbUsuarios_usua_ID PRIMARY KEY (usua_ID), 
	CONSTRAINT UQ_acce_tbUsuarios_usua_Usuario UNIQUE (usua_Usuario),
    
)
GO






/*TABLAS ESQUEMA PARQ*/

CREATE TABLE parq.tbCargos(
	carg_ID						INT IDENTITY(1,1),
	carg_Nombre					VARCHAR(300),
	carg_Estado					INT DEFAULT 1,
	carg_UsuarioCreador			INT,
	carg_FechaCreacion			DATETIME DEFAULT GETDATE(),
	carg_UsuarioModificador		INT,
	carg_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbCargos_carg_ID PRIMARY KEY (carg_ID),
	CONSTRAINT UQ_parq_tbCargos_carg_Nombre UNIQUE (carg_Nombre),
)
GO

CREATE TABLE parq.tbRegiones(
	regi_ID						INT IDENTITY(1,1),
	regi_Nombre					VARCHAR(200),
	regi_Estado					INT DEFAULT 1,
	regi_UsuarioCreador			INT,
	regi_FechaCreacion			DATETIME DEFAULT GETDATE(),
	regi_UsuarioModificador		INT,
	regi_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbRegiones_regi_ID PRIMARY KEY (regi_ID),
	CONSTRAINT UQ_parq_tbRegiones_regi_Nombre UNIQUE (regi_Nombre),
)
GO

CREATE TABLE parq.tbClientes(
	clie_ID						INT IDENTITY(1,1),
	clie_Nombres				VARCHAR(300),
	clie_Apellidos				VARCHAR(300),
	clie_DNI					CHAR(15),
	clie_Sexo					CHAR(1),
	clie_Telefono				CHAR(9),
	clie_Estado					INT DEFAULT 1,
	clie_UsuarioCreador			INT DEFAULT 1,
	clie_FechaCreacion			DATETIME DEFAULT GETDATE(),
	clie_UsuarioModificador		INT,
	clie_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbClientes_clie_ID PRIMARY KEY(clie_ID),
	CONSTRAINT CK_parq_tbClientes_clie_Sexo CHECK (clie_Sexo = 'M' OR clie_Sexo = 'F'),
	CONSTRAINT UQ_parq_tbClientes_clie_DNI UNIQUE (clie_DNI),
	CONSTRAINT UQ_parq_tbClientes_clie_Telefono UNIQUE (clie_Telefono),
)
GO

CREATE TABLE parq.tbClientesRegistrados(
	clre_ID						INT IDENTITY(1,1),
	clie_ID						INT,
	clre_Usuario				VARCHAR(300),
	clre_Email					NVARCHAR(300),
	clre_Contraseña				NVARCHAR(300),
	clre_Estado					INT DEFAULT 1,
	clre_UsuarioCreador			INT,
	clre_FechaCreacion			DATETIME DEFAULT GETDATE(),
	clre_UsuarioModificador		INT,
	clre_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbClientesRegistrados_clre_ID PRIMARY KEY (clre_ID),
	CONSTRAINT FK_parq_tbClientesRegistrados_tbClientes_clie_ID FOREIGN KEY (clie_ID) REFERENCES parq.tbClientes(clie_ID),
	CONSTRAINT UQ_parq_tbClientesRegistrados_clre_Usuario UNIQUE (clre_Usuario),
	CONSTRAINT UQ_parq_tbClientesRegistrados_clre_Email UNIQUE (clre_Email),

)
GO

CREATE TABLE parq.tbAreas(
	area_ID						INT IDENTITY(1,1),
	area_Nombre					VARCHAR(300),
	area_Descripcion			VARCHAR(300),
	regi_ID						INT,
	area_UbicaionReferencia		VARCHAR(300),
	area_Imagen					NVARCHAR(MAX),
	area_Estado					INT DEFAULT 1,
	area_UsuarioCreador			INT,
	area_FechaCreacion			DATETIME DEFAULT GETDATE(),
	area_UsuarioModificador		INT,
	area_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbAreas_area_ID PRIMARY KEY (area_ID),
	CONSTRAINT FK_parq_tbAreas_tbRegiones_regi_ID FOREIGN KEY (regi_ID) REFERENCES parq.tbRegiones (regi_ID),
	CONSTRAINT UQ_parq_tbAreas_area_Nombre UNIQUE (area_Nombre),
)
GO

CREATE TABLE parq.tbTickets(
	tckt_ID						INT IDENTITY(1,1),
	tckt_Nombre					VARCHAR(300),
	tckt_Precio					INT,
	tckt_Estado					INT DEFAULT 1,
	tckt_UsuarioCreador			INT,
	tckt_FechaCreacion			DATETIME DEFAULT GETDATE(),
	tckt_UsuarioModificador		INT,
	tckt_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbTickets_tckt_ID PRIMARY KEY (tckt_ID),
	CONSTRAINT UQ_parq_tbTickets_tckt_Nombre UNIQUE (tckt_Nombre),
	CONSTRAINT CK_parq_tbTickets_tckt_Precio CHECK (tckt_Precio > 0),
)
GO

CREATE TABLE parq.tbTicketsCliente(
	ticl_ID						INT IDENTITY(1,1),
	tckt_ID						INT,
	clie_ID						INT,	
	ticl_Cantidad				INT,
	ticl_FechaCompra			DATETIME DEFAULT GETDATE(),
	ticl_FechaUso				DATETIME,
	ticl_Estado					INT DEFAULT 1,
	ticl_UsuarioCreador			INT,
	ticl_FechaCreacion			DATETIME DEFAULT GETDATE(),
	ticl_UsuarioModificador		INT,
	ticl_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbTicketsCliente_ticl_ID PRIMARY KEY (ticl_ID),
	CONSTRAINT FK_parq_tbTicletsCliente_tbClientes_clie_ID FOREIGN KEY (clie_ID) REFERENCES parq.tbClientes(clie_ID),
	CONSTRAINT FK_parq_tbTicketsCliente_tbTickets_tckt_ID FOREIGN KEY (tckt_ID) REFERENCES parq.tbTickets (tckt_ID),
	CONSTRAINT CK_parq_tbTicketsCliente_ticl_Cantidad CHECK (ticl_Cantidad > 0), 
)
GO

CREATE TABLE parq.tbAtracciones(
	atra_ID						INT IDENTITY(1,1),
	area_ID						INT,
	atra_Nombre					VARCHAR (300),
	atra_Descripcion			VARCHAR (300),
	regi_ID						INT,
	atra_ReferenciaUbicacion	VARCHAR(300),
	atra_LimitePersonas			INT,
	atra_DuracionRonda			TIME,
	atra_Imagen					NVARCHAR(MAX),
	atra_Estado					INT DEFAULT 1,
	atra_UsuarioCreador			INT,
	atra_FechaCreacion			DATETIME DEFAULT GETDATE(),
	atra_UsuarioModificador		INT,
	atra_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbAtracciones_atra_ID PRIMARY KEY (atra_ID),
	CONSTRAINT FK_parq_tbAtracciones_tbAreas_area_ID FOREIGN KEY (area_ID) REFERENCES parq.tbAreas (area_ID),
	CONSTRAINT FK_parq_tbAtracciones_tbRegiones_regi_ID FOREIGN KEY (regi_ID) REFERENCES parq.tbRegiones (regi_ID)

)
GO

CREATE TABLE parq.tbTemporizadores(
	temp_ID						INT IDENTITY(1,1),
	clie_ID						INT,
	atra_ID						INT,
	temp_Expiracion				TIME,
	temp_Estado					INT DEFAULT 1,
	temp_UsuarioCreador			INT,
	temp_FechaCreacion			DATETIME DEFAULT GETDATE(),
	temp_UsuarioModificador		INT,
	temp_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbTemporizadores_temp_ID PRIMARY KEY (temp_ID),
	CONSTRAINT FK_parq_tbTemporizadores_tbClientes FOREIGN KEY (clie_ID) REFERENCES parq.tbClientes(clie_ID),
	CONSTRAINT FK_parq_tbTemporizadores_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones (atra_ID),
)
GO

CREATE TABLE parq.tbEmpleados(
	empl_ID						INT IDENTITY(1,1),
	empl_PrimerNombre			VARCHAR(300),
	empl_SegundoNombre			VARCHAR(300),
	empl_PrimerApellido			VARCHAR(300),
	empl_SegundoApellido		VARCHAR(300),
	empl_DNI					CHAR(15),
	empl_Email					NVARCHAR(300),
	empl_Telefono				CHAR(9),
	empl_Sexo					CHAR(1),
	civi_ID						INT,
	carg_ID						INT,
	empl_Estado					INT DEFAULT 1,
	empl_UsuarioCreador			INT DEFAULT 1,
	empl_FechaCreacion			DATETIME DEFAULT GETDATE(),
	empl_UsuarioModificador		INT,
	empl_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbEmpleados_empl_ID PRIMARY KEY (empl_ID),
	CONSTRAINT CK_parq_tbEmpleados_empl_Sexo CHECK (empl_Sexo = 'M' OR empl_Sexo = 'F'),
	CONSTRAINT UQ_parq_tbEmpleados_empl_DNI UNIQUE (empl_DNI),
	CONSTRAINT UQ_parq_tbEmpleados_empl_Telefono UNIQUE (empl_Telefono),
	CONSTRAINT FK_parq_tbEmpleados_gral_tbEstadosCiviles_civi_ID FOREIGN KEY (civi_ID) REFERENCES gral.tbEstadosCiviles (civi_ID),
	CONSTRAINT FK_parq_tbEmpleados_tbCargos_carg_ID FOREIGN KEY (carg_ID) REFERENCES parq.tbCargos (carg_ID),
)
GO



CREATE TABLE parq.tbQuioscos(
	quio_ID						INT IDENTITY(1,1),
	area_ID						INT,
	quio_Nombre					VARCHAR(300),
	empl_ID						INT,
	regi_ID						INT,
	quio_ReferenciaUbicacion	VARCHAR (300),
	quio_Imagen					NVARCHAR(MAX),
	quio_Estado					INT DEFAULT 1,
	quio_UsuarioCreador			INT,
	quio_FechaCreacion			DATETIME DEFAULT GETDATE(),
	quio_UsuarioModificador		INT,
	quio_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbQuioscos_quio_ID PRIMARY KEY (quio_ID), 
	CONSTRAINT FK_parq_tbQuioscos_tbAreas_area_ID FOREIGN KEY (area_ID) REFERENCES parq.tbAreas (area_ID),
	CONSTRAINT FK_parq_tbQuioscos_tbEmpleados_empl_ID FOREIGN KEY (empl_ID) REFERENCES parq.tbEmpleados (empl_ID),
	CONSTRAINT FK_parq_tbQuioscos_tbRegiones_regi_ID FOREIGN KEY (regi_ID) REFERENCES parq.tbRegiones (regi_ID),
	CONSTRAINT UQ_parq_tbQuioscos_quio_Nombre UNIQUE (quio_Nombre),
)
GO

CREATE TABLE parq.tbGolosinas(
	golo_ID						INT IDENTITY(1,1),
	golo_Nombre					VARCHAR(300),
	golo_Precio					INT,
	golo_Estado					INT DEFAULT 1,
	golo_UsuarioCreador			INT,
	golo_FechaCreacion			DATETIME DEFAULT GETDATE(),
	golo_UsuarioModificador		INT,
	golo_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbGolosinas_golo_ID PRIMARY KEY (golo_ID), 
	CONSTRAINT UQ_parq_tbGolosinas_golo_Nombre UNIQUE (golo_Nombre),
)
GO

CREATE TABLE parq.tbInsumosQuiosco(
	insu_ID						INT IDENTITY(1,1),
	quio_ID						INT,
	golo_ID						INT,
	insu_Stock					INT,
	insu_Estado					INT DEFAULT 1,
	insu_UsuarioCreador			INT,
	insu_FechaCreacion			DATETIME DEFAULT GETDATE(),
	insu_UsuarioModificador		INT,
	insu_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbInsumosQuiosco_insu_ID PRIMARY KEY (insu_ID),
	CONSTRAINT FK_parq_tbInsumosQuioscos_tbQuioscos_quio_ID FOREIGN KEY (quio_ID) REFERENCES parq.tbQuioscos (quio_ID),
	CONSTRAINT FK_parq_tbInsumosQuiosco_tbGolosinas_golo_ID FOREIGN KEY (golo_ID) REFERENCES parq.tbGolosinas(golo_ID),
	CONSTRAINT CK_parq_tbInsumosQuioscos_insu_Stock CHECK (insu_Stock > 0),
)
GO

CREATE TABLE fact.tbVentasQuiosco(
	vent_ID						INT IDENTITY(1,1),
	quio_ID						INT,
	pago_ID						INT,
	vent_Estado					INT DEFAULT 1,
	vent_UsuarioCreador			INT,
	vent_FechaCreacion			DATETIME DEFAULT GETDATE(),
	vent_UsuarioModificador		INT,
	vent_FechaModificacion		DATETIME,	

	CONSTRAINT PK_fact_tbVentasQuiosco_vent_ID PRIMARY KEY (vent_ID),
	CONSTRAINT FK_fact_tbVentasQuiosco_tbQuioscos_quio_ID FOREIGN KEY (quio_ID) REFERENCES parq.tbQuioscos (quio_ID),
	CONSTRAINT FK_fact_tbVentasQuiosco_gral_tbMetodosPago_pago_ID FOREIGN KEY (pago_ID) REFERENCES gral.tbMetodosPago (pago_ID),
)
GO

CREATE TABLE fact.tbVentasQuioscoDetalle(
	deta_ID						INT IDENTITY(1,1),
	vent_ID						INT,
	golo_ID						INT,
	deta_Cantidad				INT,
	deta_Estado					INT DEFAULT 1,
	deta_UsuarioCreador			INT,
	deta_FechaCreacion			DATETIME DEFAULT GETDATE(),
	deta_UsuarioModificador		INT,
	deta_FechaModificacion		DATETIME,
	CONSTRAINT PK_fact_tbVentasQuioscoDetalle_deta_ID PRIMARY KEY (deta_ID),
	CONSTRAINT FK_fact_tbVentasQuioscoDetalle_tbVentasQuiosco_vent_ID FOREIGN KEY (vent_ID) REFERENCES fact.tbVentasQuiosco (vent_ID),
	CONSTRAINT FK_fact_tbVentasQuioscoDetalle_tbGolosinas_golo_ID FOREIGN KEY (golo_ID) REFERENCES parq.tbGolosinas (golo_ID),
	CONSTRAINT CK_fact_tbVentasQuioscoDetalle_deta_Cantidad CHECK (deta_Cantidad > 0),
)	
GO

CREATE TABLE parq.tbRatings(
	rati_ID				INT IDENTITY(1,1),
	atra_ID				INT,
	clie_ID				INT,
	rati_Estrellas		INT,
	rati_Comentario		VARCHAR(300),

	CONSTRAINT PK_parq_tbRatings_rati_ID PRIMARY KEY (rati_ID),
	CONSTRAINT FK_parq_tbRatings_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones(atra_ID),
	CONSTRAINT FK_parq_tbRatings_tbClientes_clie_ID FOREIGN KEY (clie_ID) REFERENCES parq.tbClientes (clie_ID),
	CONSTRAINT CK_parq_tbRatings_rati_Estrellas CHECK (rati_Estrellas BETWEEN 0 AND 5),
)
GO

--DECLARE @RandomCode VARCHAR(30);
--SET @RandomCode = CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + REPLACE(NEWID(), '-', '');
--SELECT @RandomCode AS UniqueCode;
