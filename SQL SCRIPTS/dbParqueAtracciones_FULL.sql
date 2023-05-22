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
CREATE SCHEMA fila
GO


/*TABLAS ESQUEMA GRAL*/

--CREACION DE TABLA tbEstadosCiviles
CREATE TABLE gral.tbEstadosCiviles(
	civi_ID					INT IDENTITY(1,1),
	civi_Descripcion		VARCHAR(200),
	civi_Habilitado			INT DEFAULT 1,
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
	dept_Habilitado				INT DEFAULT 1,
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
	muni_Habilitado				INT DEFAULT 1,
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
	pago_Habilitado				INT DEFAULT 1,
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
	usua_Clave					NVARCHAR(MAX),
	usua_Admin					BIT,
	empl_ID						INT,
	role_ID                     INT,
	usua_Img					NVARCHAR(MAX),
	usua_Habilitado				INT DEFAULT 1,
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
	carg_Habilitado				INT DEFAULT 1,
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
	regi_Habilitado				INT DEFAULT 1,
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
	clie_Habilitado				INT DEFAULT 1,
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
	clre_Clave					NVARCHAR(MAX),
	clre_Habilitado				INT DEFAULT 1,
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
	area_Habilitado				INT DEFAULT 1,
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
	tckt_Habilitado				INT DEFAULT 1,
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
	ticl_Habilitado				INT DEFAULT 1,
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
	atra_Habilitado				INT DEFAULT 1,
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
	empl_Habilitado				INT DEFAULT 1,
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
	quio_Habilitado				INT DEFAULT 1,
	quio_Estado					INT DEFAULT 1,
	quio_UsuarioCreador			INT,
	quio_FechaCreacion			DATETIME DEFAULT GETDATE(),
	quio_UsuarioModificador		INT,
	quio_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbQuioscos_quio_ID PRIMARY KEY (quio_ID), 
	CONSTRAINT FK_parq_tbQuioscos_tbAreas_area_ID FOREIGN KEY (area_ID) REFERENCES parq.tbAreas (area_ID),
	CONSTRAINT FK_parq_tbQuioscos_tbEmpleados_empl_ID FOREIGN KEY (empl_ID) REFERENCES parq.tbEmpleados (empl_ID),
	CONSTRAINT FK_parq_tbQuioscos_tbRegiones_regi_ID FOREIGN KEY (regi_ID) REFERENCES parq.tbRegiones (regi_ID),

)
GO

CREATE TABLE parq.tbGolosinas(
	golo_ID						INT IDENTITY(1,1),
	golo_Nombre					VARCHAR(300),
	golo_Precio					INT,
	golo_Habilitado				INT DEFAULT 1,
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
	insu_Habilitado				INT DEFAULT 1,
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

CREATE TABLE parq.tbRatings(
	rati_ID						INT IDENTITY(1,1),
	atra_ID						INT,
	clie_ID						INT,
	rati_Estrellas				INT,
	rati_Comentario				VARCHAR(300),
	rati_Habilitado				INT DEFAULT 1,
	rati_Estado					INT DEFAULT 1,
	rati_UsuarioCreador			INT,
	rati_FechaCreacion			DATETIME DEFAULT GETDATE(),
	rati_UsuarioModificador		INT,
	rati_FechaModificacion		DATETIME,

	CONSTRAINT PK_parq_tbRatings_rati_ID PRIMARY KEY (rati_ID),
	CONSTRAINT FK_parq_tbRatings_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones(atra_ID),
	CONSTRAINT FK_parq_tbRatings_tbClientes_clie_ID FOREIGN KEY (clie_ID) REFERENCES parq.tbClientes (clie_ID),
	CONSTRAINT CK_parq_tbRatings_rati_Estrellas CHECK (rati_Estrellas BETWEEN 0 AND 5),
)
GO



/*TABLAS ESQUEMA FILA*/

CREATE TABLE fila.tbTemporizadores(
	temp_ID						INT IDENTITY(1,1),
	ticl_ID						INT,
	atra_ID						INT,
	temp_Expiracion				TIME,
	temp_TiempoRestante			TIME,
	temp_FilaPosicion			INT,
	temp_Habilitado				INT DEFAULT 1,
	temp_Estado					INT DEFAULT 1,
	temp_UsuarioCreador			INT,
	temp_FechaCreacion			DATETIME DEFAULT GETDATE(),
	temp_UsuarioModificador		INT,
	temp_FechaModificacion		DATETIME,

	CONSTRAINT PK_fila_tbTemporizadores_temp_ID PRIMARY KEY (temp_ID),
	CONSTRAINT FK_fila_tbTemporizadores_parq_tbTicketsCliente FOREIGN KEY (ticl_ID) REFERENCES parq.tbTicketsCLiente (ticl_ID),
	CONSTRAINT FK_fila_tbTemporizadores_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones (atra_ID),
)
GO

CREATE TABLE fila.tbTipoFilas(
	tifi_ID						INT IDENTITY(1,1),
	tifi_Nombre					VARCHAR(300),
	tifi_Habilitado				INT DEFAULT 1,
	tifi_Estado					INT DEFAULT 1,
	tifi_UsuarioCreador			INT,
	tifi_FechaCreacion			DATETIME DEFAULT GETDATE(),
	tifi_UsuarioModificador		INT,
	tifi_FechaModificacion		DATETIME,

	CONSTRAINT PK_fila_tbTipoFilas_tifi_ID PRIMARY KEY (tifi_ID),
)
GO

CREATE TABLE fila.tbFilasAtraccion(
	fiat_ID						INT IDENTITY(1,1),
	tifi_ID						INT,
	atra_ID						INT,
	fiat_Habilitado				INT DEFAULT 1,
	fiat_Estado					INT DEFAULT 1,
	fiat_UsuarioCreador			INT,
	fiat_FechaCreacion			DATETIME DEFAULT GETDATE(),
	fiat_UsuarioModificador		INT,
	fiat_FechaModificacion		DATETIME,

	CONSTRAINT PK_fila_tbFilasAtraccion_fiat_ID PRIMARY KEY (fiat_ID),
	CONSTRAINT FK_fila_tbFilasAtraccion_tbTipoFilas_tifi_ID FOREIGN KEY (tifi_ID) REFERENCES fila.tbTipoFilas (tifi_ID),
	CONSTRAINT FK_fila_tbFilasAtraccion_parq_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones (atra_ID),

)
GO

CREATE TABLE fila.tbFilasPosiciones(
	fipo_ID				INT IDENTITY(1,1),
	fiat_ID				INT,
	ticl_ID				INT,
	fipo_HoraIngreso	TIME,
	
	CONSTRAINT PK_fila_tbFilasPosiciones_fipo_ID PRIMARY KEY (fipo_ID),
	CONSTRAINT FK_fila_tbFilasPosiciones_tbFilasAtraccion_fiat_ID FOREIGN KEY (fiat_ID) REFERENCES fila.tbFilasAtraccion (fiat_ID),
	CONSTRAINT FK_fila_tbFilasPosiciones_parq_tbTicketsCliente_ticl_ID FOREIGN KEY (ticl_ID) REFERENCES parq.tbTicketsCliente (ticl_ID)
)
GO

CREATE TABLE fila.tbHistorialFilasPosiciones(
	hipo_ID						INT IDENTITY(1,1),
	fiat_ID						INT,
	ticl_ID						INT,
	hipo_FechaIngreso			DATETIME,
	hipo_Habilitado				INT DEFAULT 1,
	hipo_Estado					INT DEFAULT 1,
	hipo_UsuarioCreador			INT,
	hipo_FechaCreacion			DATETIME DEFAULT GETDATE(),
	hipo_UsuarioModificador		INT,
	hipo_FechaModificacion		DATETIME,

	CONSTRAINT PK_fila_tbHistorialFilasPosiciones_hipo_ID PRIMARY KEY (hipo_ID),
	CONSTRAINT FK_fila_tbHistorialFilasPosiciones_tbFilasAtraccion_fiat_ID FOREIGN KEY (fiat_ID) REFERENCES fila.tbFilasAtraccion (fiat_ID),
	CONSTRAINT FK_fila_tbHistorialFilasPosiciones_parq_tbTicketsCliente_ticl_ID FOREIGN KEY (ticl_ID) REFERENCES parq.tbTicketsCliente (ticl_ID),

)
GO

CREATE TABLE fila.tbVisitantesAtraccion(
	viat_ID				INT IDENTITY(1,1),
	atra_ID				INT,
	ticl_ID				INT,
	viat_HoraEntrada	TIME,

	CONSTRAINT PK_fila_tbVisitantesAtraccion_viat_ID PRIMARY KEY (viat_ID),
	CONSTRAINT FK_fila_tbVisitantesAtraccion_parq_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones (atra_ID),
	CONSTRAINT FK_fila_tbVisitantesAtraccion_parq_tbTicketsCliente_ticl_ID FOREIGN KEY (ticl_ID) REFERENCES parq.tbTicketsCliente (ticl_ID),

)
GO

CREATE TABLE fila.tbHistorialVisitantesAtraccion(
	hiat_ID						INT IDENTITY(1,1),
	atra_ID						INT,
	ticl_ID						INT,
	hiat_Habilitado				INT DEFAULT 1,
	hiat_Estado					INT DEFAULT 1,
	hiat_UsuarioCreador			INT,
	hiat_FechaCreacion			DATETIME DEFAULT GETDATE(),
	hiat_UsuarioModificador		INT,
	hiat_FechaModificacion		DATETIME,

	CONSTRAINT PK_fila_tbHistorialVisitantesAtraccion_hiat_ID PRIMARY KEY (hiat_ID),
	CONSTRAINT FK_fila_tbHistorialVisitantesAtraccion_parq_tbAtracciones_atra_ID FOREIGN KEY (atra_ID) REFERENCES parq.tbAtracciones (atra_ID),
	CONSTRAINT FK_fila_tbHistorialVisitantesAtraccion_parq_tbTicketsCliente_ticl_ID FOREIGN KEY (ticl_ID) REFERENCES parq.tbTicketsCliente (ticl_ID),

)
GO



/*TABLAS ESQUEMA FACT*/

CREATE TABLE fact.tbVentasQuiosco(
	vent_ID						INT IDENTITY(1,1),
	quio_ID						INT,
	clie_ID						INT,
	pago_ID						INT,
	vent_Habilitado				INT DEFAULT 1,
	vent_Estado					INT DEFAULT 1,
	vent_UsuarioCreador			INT,
	vent_FechaCreacion			DATETIME DEFAULT GETDATE(),
	vent_UsuarioModificador		INT,
	vent_FechaModificacion		DATETIME,	

	CONSTRAINT PK_fact_tbVentasQuiosco_vent_ID PRIMARY KEY (vent_ID),
	CONSTRAINT FK_fact_tbVentasQuiosco_tbQuioscos_quio_ID FOREIGN KEY (quio_ID) REFERENCES parq.tbQuioscos (quio_ID),
	CONSTRAINT FK_fact_tbVentasQuiosco_parq_tbClientes_clie_ID FOREIGN KEY (clie_ID) REFERENCES parq.tbClientes (clie_ID),
	CONSTRAINT FK_fact_tbVentasQuiosco_gral_tbMetodosPago_pago_ID FOREIGN KEY (pago_ID) REFERENCES gral.tbMetodosPago (pago_ID),
)
GO

CREATE TABLE fact.tbVentasQuioscoDetalle(
	deta_ID						INT IDENTITY(1,1),
	vent_ID						INT,
	insu_ID						INT,
	deta_Cantidad				INT,
	deta_Habilitado				INT DEFAULT 1,
	deta_Estado					INT DEFAULT 1,
	deta_UsuarioCreador			INT,
	deta_FechaCreacion			DATETIME DEFAULT GETDATE(),
	deta_UsuarioModificador		INT,
	deta_FechaModificacion		DATETIME,
	CONSTRAINT PK_fact_tbVentasQuioscoDetalle_deta_ID PRIMARY KEY (deta_ID),
	CONSTRAINT FK_fact_tbVentasQuioscoDetalle_tbVentasQuiosco_vent_ID FOREIGN KEY (vent_ID) REFERENCES fact.tbVentasQuiosco (vent_ID),
	CONSTRAINT FK_fact_tbVentasQuioscoDetalle_tbInsumosQuiosco_insu_ID FOREIGN KEY (insu_ID) REFERENCES parq.tbInsumosQuiosco (insu_ID),
	CONSTRAINT CK_fact_tbVentasQuioscoDetalle_deta_Cantidad CHECK (deta_Cantidad > 0),
)	
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

			SELECT 200 AS codeStatus, 'Usuario Creado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Usuario Modificado con �xito' AS messageStatus

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

			SELECT 200 AS codeStatus, 'Usuario Eliminado con �xito' AS messageStatus

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
					usua_Usuario = 'Usuario o Contrase�a Incorrectos'
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
		role_Estado, 
		role_UsuarioCreador,
		empl_crea = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = role_UsuarioCreador), 
		role_FechaCreacion, 
		role_UsuarioModificador,
		empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = role_UsuarioModificador), 
		role_FechaModificacion
		FROM acce.tbRoles

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

			SELECT 200 AS codeStatus, 'Rol Creado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Rol Modificado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Rol Eliminado con �xito' AS messageStatus

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO



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
	INSERT INTO [acce].tbRolesXPantallas
	(role_ID, pant_ID, ropa_UsuarioCreador)
	VALUES
	(@role_ID,@pant_ID,@ropa_UsuarioCreador)

	SELECT 200 AS codeStatus, 'Acceso Agregado con �xito' AS messageStatus

END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbPantallasPorRol_DELETE
@role_ID INT,
@pant_ID INT,
@ropa_UsuarioCreador INT
AS
BEGIN
DELETE FROM  [acce].tbRolesXPantallas
WHERE role_ID=@role_ID AND pant_ID = @pant_ID

INSERT INTO [acce].tbRolesXPantallas
	(role_ID, pant_ID, ropa_UsuarioCreador)
	VALUES
	(@role_ID,@pant_ID,@ropa_UsuarioCreador)

	SELECT 200 AS codeStatus, 'Acceso Editado con �xito' AS messageStatus

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

			SELECT 200 AS codeStatus, 'Estado Civil creado con �xito' AS messageStatus

			END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM  gral.tbEstadosCiviles WHERE civi_Descripcion = @civi_Descripcion)
		 BEGIN
			
			INSERT INTO  gral.tbEstadosCiviles
			(civi_Descripcion, civi_UsuarioCreador)
			VALUES
			(@civi_Descripcion, @civi_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Estado Civil creado con �xito' AS messageStatus
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

				SELECT 200 AS codeStatus, 'Estado Civil Modificado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Estado Civil Modificado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Estado Civil Eliminado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Departamento Civil creado con �xito' AS messageStatus

			END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM  gral.tbEstadosCiviles WHERE civi_Descripcion = @dept_Nombre)
		 BEGIN
			
			INSERT INTO  gral.tbDepartamentos
			(dept_Codigo, dept_Nombre, dept_UsuarioCreador)
			VALUES
			(@dept_Codigo,@dept_Nombre,@dept_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Estado Civil creado con �xito' AS messageStatus
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

				SELECT 200 AS codeStatus, 'Departamento Modificado con �xito' AS messageStatus

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

			SELECT 200 AS codeStatus, 'Departamento Modificado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Departamento Eliminado con �xito' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Municipio Creado con �xito' AS messageStatus
			
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

			SELECT 200 AS codeStatus, 'Municipio Creado con �xito' AS messageStatus
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
			
			SELECT 200 AS codeStatus, 'yes Municipio Editado con �xito' AS messageStatus

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

			SELECT 200 AS codeStatus, 'Municipio Editado con �xito' AS messageStatus
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
				SELECT 200 AS codeStatus, 'Cargo actualizado con �xito' AS messageStatus
			END
		ELSE IF NOT EXISTS (SELECT * FROM parq.tbCargos WHERE carg_Nombre = @carg_Nombre AND carg_ID != @carg_ID)
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
							SELECT 200 AS codeStatus, 'Cargo eliminado con �xito' AS messageStatus
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
					SELECT 200 AS codeStatus, 'Area creada con �xito' AS messageStatus
				 END
		    ELSE IF NOT EXISTS (SELECT * FROM parq.tbAreas WHERE area_Nombre = @area_Nombre)
				BEGIN
					INSERT INTO parq.tbAreas(area_Nombre, area_Descripcion, regi_ID, area_UbicaionReferencia, area_Imagen, area_UsuarioCreador)
					VALUES					(@area_Nombre, @area_Descripcion, @regi_ID, @area_UbicaionReferencia, @area_Imagen, @area_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Area creada con �xito' AS messageStatus
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
				SELECT 200 AS codeStatus, 'Area actualizada con �xito' AS messageStatus
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
				SELECT 200 AS codeStatus, 'Area actualizada con �xito' AS messageStatus
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
						SELECT 200 AS codeStatus, 'Area eliminada con �xito' AS messageStatus
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
					SELECT 200 AS codeStatus, 'Ticket creado con �xito' AS messageStatus
				 END
		    ELSE IF NOT EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre)
				BEGIN
					INSERT INTO parq.tbTickets(tckt_Nombre, tckt_Precio, tckt_UsuarioCreador)
					VALUES					  (@tckt_Nombre, @tckt_Precio, @tckt_UsuarioCreador)
					SELECT 200 AS codeStatus, 'Ticket creado con �xito' AS messageStatus
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
				SELECT 200 AS codeStatus, 'Ticket actualizado con �xito' AS messageStatus
			END
		 ELSE IF NOT EXISTS (SELECT * FROM parq.tbTickets WHERE tckt_Nombre = @tckt_Nombre AND tckt_ID != @tckt_ID )
			BEGIN
				UPDATE parq.tbTickets
				SET		tckt_Nombre =	@tckt_Nombre, 
						tckt_Precio = @tckt_Precio,
						tckt_UsuarioModificador = @tckt_UsuarioModificador
				WHERE	tckt_ID   =		@tckt_ID
				SELECT 200 AS codeStatus, 'Ticket actualizado con �xito' AS messageStatus
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
						SELECT 200 AS codeStatus, 'Ticket eliminado con �xito' AS messageStatus
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
	  , clie.clie_Nombres + + ' ' + clie.clie_Apellidos AS clie_Nombres
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
					SELECT 200 AS codeStatus, 'Ticket Detalle creado con �xito' AS messageStatus
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
				SELECT 200 AS codeStatus, 'Ticket Detalle actualizado con �xito' AS messageStatus
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
						SELECT 200 AS codeStatus, 'Ticket Detalle eliminado con �xito' AS messageStatus
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
      ,atracc.area_ID
	  , are.area_Descripcion
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
  INNER JOIN parq.tbAreas are ON atracc.area_ID = are.area_ID

--*************** SELECT DE ATRACCIONES ******************-
GO
CREATE OR ALTER PROCEDURE parq.UDP_tbAtracciones_SELECT
AS
BEGIN
	SELECT [atra_ID]
      ,area_ID
	  ,area_Descripcion
      ,[atra_Nombre]
      ,[atra_Descripcion]
      ,regi_ID
	  ,regi_Nombre
      ,[atra_ReferenciaUbicacion]
      ,[atra_LimitePersonas]
      ,atra_DuracionRonda = CONVERT(NVARCHAR, atra_DuracionRonda)
      ,[atra_Imagen]
      ,[atra_Habilitado]
      ,[atra_Estado]
      ,[atra_UsuarioCreador]
	  , usu_Crea
      ,[atra_FechaCreacion]
      ,[atra_UsuarioModificador]
	  ,usu_Modifica
      ,[atra_FechaModificacion]
	  , empl_crea =		(SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = atra_UsuarioCreador)
	  , empl_Modifica = (SELECT nombreEmpleado FROM acce.VW_Usuarios WHERE usua_ID = atra_UsuarioModificador)
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
					SELECT 200 AS codeStatus, 'Atraccion creada con �xito' AS messageStatus
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
						atra_LimitePersonas = @atra_LimitePersonas,
						atra_DuracionRonda = @atra_DuracionRonda,
						atra_Imagen = @atra_Imagen,
						atra_UsuarioModificador = @atra_UsuarioModificador
				WHERE	atra_ID   =		@atra_ID
				SELECT 200 AS codeStatus, 'Atraccion actualizada con �xito' AS messageStatus
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
						SELECT 500 AS codeStatus, 'La Atraccion que desea eliminar est� en uso.' AS messageStatus
					END
				ELSE
					BEGIN
						UPDATE parq.VW_tbAtracciones
							SET atra_Estado	= 0 WHERE atra_ID =	@atra_ID
						SELECT 200 AS codeStatus, 'Atraccion eliminado con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Empleado agregado con �xito!' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Empleado actualizado con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Empleado eliminado con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Quiosco ingresado con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Quiosco actualizado con �xito!' AS messageStatus
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

			SELECT 200 AS codeStatus, 'Quiosco eliminado con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Golosina ingresada con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Golosina eliminada con �xito' AS messageStatus
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

					SELECT 200 AS codeStatus, 'Cantidad exitosamente a�adida al stock' AS messageStatus
				END
			ELSE IF EXISTS (SELECT * FROM parq.tbInsumosQuiosco WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID AND insu_Estado = 0)
				BEGIN
					UPDATE parq.tbInsumosQuiosco
					SET	insu_Estado = 1,
						insu_Stock = @insu_Stock
					WHERE quio_ID = @quio_ID AND golo_ID = @golo_ID

 					SELECT 200 AS codeStatus, 'Insumo a�adido con �xito' AS messageStatus
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbInsumosQuiosco(quio_ID, golo_ID, insu_Stock, insu_UsuarioCreador)
					VALUES(@quio_ID, @golo_ID, @insu_Stock, @insu_UsuarioCreador)
					
					SELECT 200 AS codeStatus, 'Insumo a�adido con �xito' AS messageStatus
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
			SELECT 200 AS codeStatus, 'Insumo eliminado con �xito' AS messageStatus
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
					
					SELECT 200 AS codeStatus, 'Rating agregado con �xito!' AS messageStatus
				END
			ELSE
				BEGIN
					INSERT INTO parq.tbRatings(atra_ID, clie_ID, rati_Estrellas, rati_Comentario, rati_UsuarioCreador)
					VALUES(@atra_ID, @clie_ID, @rati_Estrellas, @rati_Comentario, @rati_UsuarioCreador)

					SELECT 200 AS codeStatus, 'Rating agregado con �xito!' AS messageStatus
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
			
			SELECT 200 AS codeStatus, 'Factura creada con �xito' AS messageStatus
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
			INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
			VALUES (@vent_ID, @insu_ID, @deta_Cantidad, @deta_UsuarioCreador)

			SELECT 200 AS codeStatus, 'Detalle a�adido con �xito' AS messageStatus			
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus						
	END CATCH
END
GO


EXECUTE acce.UDP_tbUsuarios_INSERT 'Admin', 1, 'Admin123', 1, NULL, 1
EXECUTE acce.UDP_tbUsuarios_LOGIN 'Admin', 'Admin123'
GO



INSERT INTO gral.tbEstadosCiviles (civi_Descripcion)
VALUES	('Soltero(a)'),
		('Casado(a)'),
		('Divorciado(a)'),
		('Viudo(a)'),
		('Union Libre')
GO

INSERT INTO gral.tbDepartamentos(dept_Codigo, dept_Nombre)
VALUES	('01','Atlántida'),
		('02','Colón'),
		('03','Comayagua'),
		('04','Copán'),
		('05','Cortés'),
		('06','Choluteca'),
		('07','El Paraíso'),
		('08','Francisco Morazán'),
		('09','Gracias a Dios'),
		('10','Intibucá'),
		('11','Islas de la Bahía'),
		('12','La Paz'),
		('13','Lempira'),
		('14','Ocotepeque'),
		('15','Olancho'),
		('16','Santa Bárbara'),
		('17','Valle'),
		('18','Yoro');
GO

INSERT INTO gral.tbMunicipios(dept_ID, muni_Codigo, muni_Nombre, muni_Estado, muni_UsuarioCreador, muni_FechaCreacion, muni_UsuarioModificador, muni_FechaModificacion)
VALUES	('1','0101','La Ceiba', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0102','El Porvenir', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0103','Tela', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0104','Jutiapa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0105','La Masica', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0106','San Francisco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0107','Arizona', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0108','Esparta', '1', NULL, GETDATE(), NULL, GETDATE()),
	

		('2','0201','Trujillo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0202','Balfate', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0203','Iriona', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0204','Limón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0205','Sabá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0206','Santa Fe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0207','Santa Rosa de Aguán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0208','Sonaguera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0209','Tocoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0210','Bonito Oriental', '1', NULL, GETDATE(), NULL, GETDATE()),


		('3',		'0301',		'Comayagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0302',		'Ajuterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0303',		'El Rosario', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0304',		'Esquías', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0305',		'Humuya', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0306',		'La Libertad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0307',		'Lamaní', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0308',		'La Trinidad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0309',		'Lejamaní', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0310',		'Meámbar', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0311',		'Minas de Oro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0312',		'Ojos de Agua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0313',		'San Jerónimo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0314',		'San José de Comayagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0315',		'San José del Potrero', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0316',		'San Luis', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0317',		'San Sebastián', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0318',		'Siguatepeque', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0319',		'Villa de San Antonio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0320',		'Las Lajas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0321',		'Taulabé', '1', NULL, GETDATE(), NULL, GETDATE()),


		('4',	'0401','Santa Rosa de Copán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0402','Cabañas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0403','Concepción', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0404','Copán Ruinas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0405','Corquín', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0406','Cucuyagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0407','Dolores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0408','Dulce Nombre', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0409','El Paraíso', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0410','Florida', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0411','La Jigua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0412','La Unión', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0413','Nueva Arcadia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0414','San Agustín', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0415','San Antonio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0416','San Jerónimo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0417','San José', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0418','San Juan de Opoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0419','San Nicolás', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0420','San Pedro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0421','Santa Rita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0422','Trinidad de Copán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0423','Veracruz', '1', NULL, GETDATE(), NULL, GETDATE()),


		('5',	'0501','San Pedro Sula', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0502','Choloma', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0503','Omoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0504','Pimienta', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0505','Potrerillos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0506','Puerto Cortés', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0507','San Antonio de Cortés', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0508','San Francisco de Yojoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0509','San Manuel', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0510','Santa Cruz de Yojoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0511','Villanueva', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0512','La Lima', '1', NULL, GETDATE(), NULL, GETDATE()),


		('6',	'0601','Choluteca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0602','Apacilagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0603','Concepción de María', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0604','Duyure', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0605','El Corpus', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0606','El Triunfo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0607','Marcovia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0608','Morolica', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0609','Namasigüe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0610','Orocuina', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0611','Pespire', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0612','San Antonio de Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0613','San Isidro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0614','San José', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0615','San Marcos de Colón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0616','Santa Ana de Yusguare', '1', NULL, GETDATE(), NULL, GETDATE()),


		('7', '0701', 'Yuscarán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0702', 'Alauca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0703', 'Danlí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0704', 'El Paraíso', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0705', 'Güinope', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0706', 'Jacaleapa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0707', 'Liure', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0708', 'Morocelí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0709', 'Oropolí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0710', 'Potrerillos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0711', 'San Antonio de Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0712', 'San Lucas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0713', 'San Matías', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0714', 'Soledad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0715', 'Teupasenti', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0716', 'Texiguat', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0717', 'Vado Ancho', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0718', 'Yauyupe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0719', 'Trojes', '1', NULL, GETDATE(), NULL, GETDATE()),


		('8', '0801', 'Distrito Central', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0802', 'Alubarén', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0803', 'Cedros', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0804', 'Curarén', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0805', 'El Porvenir', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0806', 'Guaimaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0807', 'La Libertad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0808', 'La Venta', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0809', 'Lepaterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0810', 'Maraita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0811', 'Marale', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0812', 'Nueva Armenia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0813', 'Ojojona', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0814', 'Orica', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0815', 'Reitoca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0816', 'Sabanagrande', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0817', 'San Antonio de Oriente', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0818', 'San Buenaventura', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0819', 'San Ignacio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0820', 'San Juan de Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0821', 'San Miguelito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0822', 'Santa Ana', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0823', 'Santa Lucía', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0824', 'Talanga', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0825', 'Tatumbla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0826', 'Valle de Ángeles', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0827', 'Villa de San Francisco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0828', 'Vallecillo', '1', NULL, GETDATE(), NULL, GETDATE()),


		('9', '0901', 'Puerto Lempira', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0902', 'Brus Laguna', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0903', 'Ahuas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0904', 'Juan Francisco Bulnes', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0905', 'Ramón Villeda Morales', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0906', 'Wampusirpe', '1', NULL, GETDATE(), NULL, GETDATE()),


		('10', '1001', 'La Esperanza', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1002', 'Camasca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1003', 'Colomoncagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1004', 'Concepción', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1005', 'Dolores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1006', 'Intibucá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1007', 'Jesús de Otoro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1008', 'Magdalena', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1009', 'Masaguara', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1010', 'San Antonio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1011', 'San Isidro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1012', 'San Juan', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1013', 'San Marcos de la Sierra', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1014', 'San Miguel Guancapla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1015', 'Santa Lucía', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1016', 'Yamaranguila', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1017', 'San Francisco de Opalaca', '1', NULL, GETDATE(), NULL, GETDATE()),


		('11', '1101', 'Roatán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('11', '1102', 'Guanaja', '1', NULL, GETDATE(), NULL, GETDATE()),
		('11', '1103', 'José Santos Guardiola', '1', NULL, GETDATE(), NULL, GETDATE()),
		('11', '1104', 'Utila', '1', NULL, GETDATE(), NULL, GETDATE()),


		('12', '1201', 'La Paz', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1202', 'Aguanqueterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1203', 'Cabañas.', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1204', 'Cane', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1205', 'Chinacla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1206', 'Guajiquiro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1207', 'Lauterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1208', 'Marcala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1209', 'Mercedes de Oriente', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1210', 'Opatoro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1211', 'San Antonio del Norte', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1212', 'San José', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1213', 'San Juan', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1214', 'San Pedro de Tutule', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1215', 'Santa Ana', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1216', 'Santa Elena', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1217', 'Santa María', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1218', 'Santiago de Puringla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1219', 'Yarula', '1', NULL, GETDATE(), NULL, GETDATE()),


		('13', '1301', 'Gracias', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1302', 'Belén', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1303', 'Candelaria', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1304', 'Cololaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1305', 'Erandique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1306', 'Gualcince', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1307', 'Guarita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1308', 'La Campa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1309', 'La Iguala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1310', 'Las Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1311', 'La Unión', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1312', 'La Virtud', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1313', 'Lepaera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1314', 'Mapulaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1315', 'Piraera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1316', 'San Andrés', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1317', 'San Francisco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1318', 'San Juan Guarita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1319', 'San Manuel Colohete', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1320', 'San Rafael', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1321', 'San Sebastián', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1322', 'Santa Cruz', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1323', 'Talgua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1324', 'Tambla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1325', 'Tomalá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1326', 'Valladolid', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1327', 'Virginia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1328', 'San Marcos de Caiquín', '1', NULL, GETDATE(), NULL, GETDATE()),


		('14', '1401', 'Ocotepeque', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1402', 'Belén Gualcho', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1403', 'Concepción', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1404', 'Dolores Merendón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1405', 'Fraternidad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1406', 'La Encarnación', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1407', 'La Labor', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1408', 'Lucerna', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1409', 'Mercedes', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1410', 'San Fernando', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1411', 'San Francisco del Valle', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1412', 'San Jorge', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1413', 'San Marcos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1414', 'Santa Fe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1415', 'Sensenti', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1416', 'Sinuapa', '1', NULL, GETDATE(), NULL, GETDATE()),


		('15', '1501', 'Juticalpa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1502', 'Campamento', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1503', 'Catacamas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1504', 'Concordia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1505', 'Dulce Nombre de Culmí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1506', 'El Rosario', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1507', 'Esquipulas del Norte', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1508', 'Gualaco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1509', 'Guarizama', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1510', 'Guata', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1511', 'Guayape', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1512', 'Jano', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1513', 'La Unión', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1514', 'Mangulile', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1515', 'Manto', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1516', 'Salamá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1517', 'San Esteban', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1518', 'San Francisco de Becerra', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1519', 'San Francisco de la Paz', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1520', 'Santa María del Real', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1521', 'Silca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1522', 'Yocón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1523', 'Patuca', '1', NULL, GETDATE(), NULL, GETDATE()),


		('16', '1601' , 'Santa Bárbara', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1602' , 'Arada', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1603' , 'Atima', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1604' , 'Azacualpa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1605' , 'Ceguaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1606' , 'Concepción del Norte', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1607' , 'Concepción del Sur', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1608' , 'Chinda', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1609' , 'El Níspero', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1610' , 'Gualala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1611' , 'Ilama', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1612' , 'Las Vegas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1613' , 'Macuelizo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1614' , 'Naranjito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1615' , 'Nuevo Celilac', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1616' , 'Nueva Frontera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1617' , 'Petoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1618' , 'Protección', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1619' , 'Quimistán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1620' , 'San Francisco de Ojuera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1621' , 'San José de las Colinas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1622' , 'San Luis', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1623' , 'San Marcos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1624' , 'San Nicolás', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1625' , 'San Pedro Zacapa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1626' , 'San Vicente Centenario', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1627' , 'Santa Rita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1628' , 'Trinidad', '1', NULL, GETDATE(), NULL, GETDATE()),


		('17', '1701', 'Nacaome', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1702', 'Alianza', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1703', 'Amapala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1704', 'Aramecina', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1705', 'Caridad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1706', 'Goascorán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1707', 'Langue', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1708', 'San Francisco de Coray', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1709', 'San Lorenzo', '1', NULL, GETDATE(), NULL, GETDATE()),


		('18', '1801', 'Yoro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1802', 'Arenal', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1803', 'El Negrito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1804', 'El Progreso', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1805', 'Jocón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1806', 'Morazán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1807', 'Olanchito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1808', 'Santa Rita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1809', 'Sulaco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1810', 'Victoria', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1811', 'Yorito', '1', NULL, GETDATE(), NULL, GETDATE());
GO

INSERT INTO gral.tbMetodosPago(pago_Nombre, pago_UsuarioCreador)
VALUES	('Efectivo', 1),
		('Tarjeta', 1),
		('Transferencia', 1)
GO

UPDATE gral.tbDepartamentos
SET dept_UsuarioCreador = 1

UPDATE gral.tbMunicipios
SET muni_UsuarioCreador = 1


INSERT INTO parq.tbCargos(carg_Nombre, carg_UsuarioCreador)
VALUES	('Ventanilla', 1),
		('Vendedor', 1),
		('Supervisor Atracciones', 1),
		('Aseador',1)
GO

INSERT INTO parq.tbRegiones(regi_Nombre)
VALUES	('Norte'),
		('Sur'),
		('Este'),
		('Oeste'),
		('Nordeste'),
		('Sudeste'),
		('Noroeste'),
		('Sudoeste')
GO		


INSERT INTO parq.tbClientes(clie_Nombres, clie_Apellidos, clie_DNI, clie_Sexo, clie_Telefono)
VALUES	('Juan', 'Camaney',   '0502-0045-57848', 'M', '8855-4477'),
		('Maria', 'Antonieta','0224-5578-44157', 'F', '9985-2240'),
		('David', 'Castillo', '0544-2235-42517', 'M', '7754-1142'),
		('Alejandra', 'Peña', '0104-5575-11245', 'F', '8852-2241')
GO



INSERT INTO parq.tbClientesRegistrados(clie_ID, clre_Usuario, clre_Clave, clre_Email)
VALUES	( 1, 'Juanca123', 'juanca123@', 'camaney.juan@gmail.com'),
		( 4, 'ItsAle504', 'itsale504', 'peña.alejandra@gmail.com')
GO


INSERT INTO parq.tbAreas (area_Nombre, area_Descripcion, regi_ID, area_UbicaionReferencia, area_UsuarioCreador)
VALUES	('Zona Acuática', 'Zona con ambiente acuatico, lleno de entretenimiento, incluye piscinas!', 1, 'Ubicado en la zona norte del parque', 1),
		('Montañas Rusas', 'Zona con un ambiente lleno de diversión y adrenalina!', 3, 'Ubicado en la zona Este del parque', 1),
		('Zona Extrema', 'Zona con temáticas frenesí, desde paintball, hasta airsoft!', 2, 'Ubicado en la zona Sur del parque', 1),
		('Zona Infantíl', 'Zona con un ambiente más tranquilo y familiar con lo pequeños!', 4, 'Ubicado en la zona Oeste del parque', 1)
GO


INSERT INTO parq.tbTickets(tckt_Nombre, tckt_Precio)
VALUES	('Clásico', 150),
		('VIP', 450)
GO


INSERT INTO parq.tbTicketsCliente(tckt_ID, clie_ID, ticl_Cantidad)
VALUES	(1, 1, 4),
		(2, 4, 3),
		(2, 2, 2),
		(1, 3, 6)
GO



INSERT INTO parq.tbAtracciones(area_ID, atra_Nombre, atra_Descripcion, regi_ID, atra_ReferenciaUbicacion, atra_LimitePersonas, atra_DuracionRonda, atra_UsuarioCreador)
VALUES	(1, 'Montaña Rusa', 'Solo para valientes', 1, 'A 10 metros de la entrada al area', 20, '00:05:00:00', 1),
		(2, 'La casa de los mil y un espejos', 'No te pierdas en el camino a la salida!', 2, 'Gira a la derecha despues de pasar el quiosco', 20, '00:15:00:00', 1),
		(3, 'El tren infinito', 'No te vallas a marear!', 3, 'Dirigete al este del area', 20, '00:07:00:00', 1),
		(4, 'Warzone', 'Solo puede quedar uno en pie!', 4, 'De la entrada al area dirígete a la izquierda y verás la entrada a la atracción', 20, '00:30:00:00', 1)
GO       


INSERT INTO parq.tbEmpleados(empl_PrimerNombre, empl_SegundoNombre, empl_PrimerApellido, empl_SegundoApellido, empl_DNI, empl_Email, empl_Telefono, empl_Sexo, civi_ID, carg_ID, empl_UsuarioCreador)
VALUES	('Juan', 'Pablo', 'González', 'López', '1234-6789-12345', 'juan.gonzalez@example.com', '1234-6789', 'M', 1, 1, 1),
		('María', 'Elena', 'Rodríguez', 'Gómez', '9876-4321-98765', 'maria.rodriguez@example.com', '9876-4321', 'F', 2, 1, 1),
		('Pedro', NULL, 'Sánchez', 'Martínez', '4567-9012-45678', 'pedro.sanchez@example.com', '4567-9012', 'M', 1, 2, 1),
		('Ana', 'María', 'López', 'García', '234567890123456', 'ana.lopez@example.com', '234567890', 'F', 2, 2, 1),
		('Carlos', 'Alberto', 'Ramírez', 'Vargas', '345678901234567', 'carlos.ramirez@example.com', '345678901', 'M', 3, 3, 1),
		('Laura', 'Isabel', 'Gómez', 'Hernández', '456789012345678', 'laura.gomez@example.com', '456789012', 'F', 4, 2, 1)
GO


INSERT INTO parq.tbQuioscos(area_ID, quio_Nombre, empl_ID, regi_ID, quio_ReferenciaUbicacion, quio_UsuarioCreador)
VALUES	(1, 'Quiosco La Delicia', 1, 1, 'A la par del letrero de baños', 1),
		(2, 'Quiosco Fresh & Tasty', 2, 1, 'Junto a la entrada principal', 1),
		(1, 'Quiosco La Esquina', 3, 2, 'Cerca de la fuente de agua', 1),
		(2, 'Quiosco Sweet & Salty', 4, 2, 'En la plaza de comidas', 1),
		(3, 'Quiosco Deli Corner', 5, 3, 'Al lado de la tienda de souvenirs', 1),
		(3, 'Quiosco Snack Paradise', 6, 3, 'Cerca de la atracción principal', 1)
GO


INSERT INTO parq.tbGolosinas(golo_Nombre, golo_Precio, golo_UsuarioCreador)
VALUES	('ChocoDelight', 5, 1),
		('Rainbow Drops', 3, 1),
		('Cotton Candy Crunch', 2, 1),
		('Sourlicious Gummies', 4, 1),
		('Popcorn Munchies', 3, 1),
		('Fruity Swirl Lollipop', 1, 1)
GO


INSERT INTO parq.tbInsumosQuiosco(quio_ID, golo_ID, insu_Stock, insu_UsuarioCreador)
VALUES	(1, 1, 50, 1),
		(1, 2, 100, 1),
		(2, 3, 75, 1),
		(2, 4, 60, 1),
		(3, 5, 80, 1),
		(3, 6, 90, 1),
		(4, 1, 70, 1),
		(4, 2, 85, 1),
		(5, 3, 55, 1),
		(5, 4, 40, 1),
		(6, 5, 65, 1),
		(6, 6, 50, 1),
		(1, 3, 90, 1),
		(2, 4, 75, 1),
		(3, 5, 60, 1),
		(4, 6, 85, 1)
GO


INSERT INTO parq.tbRatings(atra_ID, clie_ID, rati_Estrellas, rati_Comentario, rati_UsuarioCreador)
VALUES	(1, 1, 4, 'Excelente atracción. Me encantó la emoción que ofrece.', 1),
		(2, 2, 5, 'Increíble experiencia. No puedo esperar para volver.', 1),
		(3, 3, 3, 'La atracción estuvo bien, pero esperaba más emociones.', 1),
		(4, 4, 2, 'No quedé satisfecho con esta atracción. Falta emoción.', 1)
GO



INSERT INTO fact.tbVentasQuiosco(quio_ID, clie_ID, pago_ID, vent_UsuarioCreador)
VALUES	(1, 1, 1, 1),
		(2, 2, 2, 1),
		(3, 3, 1, 1),
		(4, 4, 2, 1)
GO


-- Inserts para la venta 1
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(1, 1, 2, 1),
		(1, 2, 3, 1)
GO

-- Inserts para la venta 2
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(2, 4, 2, 1),
		(2, 3, 1, 1)
GO

-- Inserts para la venta 3
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(3, 5, 3, 1),
		(3, 6, 2, 1)
GO

-- Inserts para la venta 4
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(4, 1, 2, 1),
		(4, 2, 3, 1)
GO



