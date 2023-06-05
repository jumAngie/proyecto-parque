using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess
{
    public class ScriptsDatabase
    {
        

        #region Cargo
        public static string UDP_Cargo_List = "parq.UDP_tbCargos_SELECT";
        public static string UDP_Cargo_Insert = "parq.UDP_tbCargos_INSERT";
        public static string UDP_Cargo_Find = "parq.UDP_tbCargos_FIND";
        public static string UDP_Cargo_Update = "parq.UDP_tbCargos_UPDATE";
        public static string UDP_Cargos_Delete = "parq.UDP_tbCargos_DELETE";
        #endregion

        #region Regiones
        public static string UDP_Regiones_List = "parq.UDP_tbRegiones_SELECT";
        public static string UDP_Regiones_Insert = "parq.UDP_tbRegiones_INSERT";
        public static string UDP_Regiones_Find = "parq.UDP_tbRegiones_FIND";
        public static string UDP_Regiones_Update = "parq.UDP_tbRegiones_UPDATE";
        public static string UDP_Regiones_Delete = "parq.UDP_tbRegiones_DELETE";
        #endregion

        #region Clientes
        public static string UDP_Clientes_List = "parq.UDP_tbClientes_SELECT";
        public static string UDP_Clientes_Insert = "parq.UDP_tbClientes_INSERT";
        public static string UDP_Clientes_Find = "parq.UDP_tbClientes_FIND";
        public static string UDP_Clientes_Update = "parq.UDP_tbClientes_UPDATE";
        public static string UDP_Clientes_Delete = "parq.UDP_tbClientes_DELETE";
        public static string UDP_Clientes_SearchByDNI = "parq.UDP_VW_tbClientes_SearchByDNI";
        #endregion

        #region Clientes Registrados
        public static string UDP_ClientesRegistrados_List = "parq.UDP_tbClientesRegistrados_SELECT";
        public static string UDP_ClientesRegistrados_Insert = "parq.UDP_tbClientesRegistrados_INSERT";
        public static string UDP_ClientesRegistrados_Find = "parq.UDP_tbClientesRegistrados_FIND";
        public static string UDP_ClientesRegistrados_Update = "parq.UDP_tbClientesRegistrados_UPDATE";
        public static string UDP_ClientesRegistrados_Delete = "parq.UDP_tbClientesRegistrados_DELETE";
        #endregion

        #region Areas
        public static string UDP_Areas_List = "parq.UDP_tbAreas_SELECT";
        public static string UDP_Areas_Insert = "parq.UDP_tbAreas_INSERT";
        public static string UDP_Areas_Find = "parq.UDP_tbAreas_FIND";
        public static string UDP_Areas_Update = "parq.UDP_tbAreas_UPDATE";
        public static string UDP_Areas_Delete = "parq.UDP_tbAreas_DELETE";
        #endregion

        #region Ticket
        public static string UDP_Ticket_List = "parq.UDP_tbTickets_SELECT";
        public static string UDP_Ticket_Insert = "parq.UDP_tbTickets_INSERT";
        public static string UDP_Ticket_Find = "parq.UDP_tbTickets_FIND";
        public static string UDP_Ticket_Update = "parq.UDP_tbTickets_UPDATE";
        public static string UDP_Ticket_Delete = "parq.UDP_tbTickets_DELETE";
        #endregion

        #region Ticket Clientes
        public static string UDP_TicketClientes_List = "parq.UDP_tbTicketClientes_SELECT";
        public static string UDP_TicketClientes_Insert = "parq.UDP_tbTicketClientes_INSERT";
        public static string UDP_TicketClientes_Find = "parq.UDP_tbTicketClientes_FIND";
        public static string UDP_TicketClientes_Update = "parq.UDP_tbTicketClientes_UPDATE";
        public static string UDP_TicketClientes_Delete = "parq.UDP_tbTicketClientes_DELETE";

        public static string UDP_TicketsCliente_FullInsert = "parq.UDP_tbTicketsCliente_FullInsert";
        #endregion

        #region Atracciones
        public static string UDP_Atracciones_List = "parq.UDP_tbAtracciones_SELECT";
        public static string UDP_Atracciones_Insert = "parq.UDP_tbAtracciones_INSERT";
        public static string UDP_Atracciones_Find = "parq.UDP_tbAtracciones_FIND";
        public static string UDP_Atracciones_Update = "parq.UDP_tbAtracciones_UPDATE";
        public static string UDP_Atracciones_Delete = "parq.UDP_tbAtracciones_DELETE";
        public static string UDP_Atracciones_AtraccionPorId = "parq.UDP_tbAtracciones_AtraccionesPorAreaId";
        #endregion


        #region Empleados
        public static string UDP_Empleados_List = "parq.UDP_VW_tbEmpleados_Select";
        public static string UDP_Empleados_Insert = "parq.UDP_tbEmpleados_Insert";
        public static string UDP_Empleados_Find = "parq.UDP_VW_tbEmpleados_Find";
        public static string UDP_Empleados_Update = "parq.UDP_tbEmpleados_Update";
        public static string UDP_Empleados_Delete = "parq.UDP_tbEmpleados_Delete";
        #endregion

        #region Quioscos
        public static string UDP_Quioscos_List = "parq.UDP_VW_tbQuioscos_Select";
        public static string UDP_Quioscos_Find = "parq.UDP_VW_tbQuioscos_Find";
        public static string UDP_Quioscos_Insert = "parq.UDP_tbQuioscos_Insert";
        public static string UDP_Quioscos_Update = "parq.UDP_tbQuioscos_Update";
        public static string UDP_Quioscos_Delete = "parq.UDP_tbQuioscos_Delete";

        #endregion

        #region Golosinas
        public static string UDP_Golosinas_List = "parq.UDP_VW_tbGolosinas_Select";
        public static string UDP_Golosinas_Find = "parq.UDP_VWtbGolosinas_Find";
        public static string UDP_Golosinas_Insert = "parq.UDP_tbGolosinas_Insert";
        public static string UDP_Golosinas_Update = "parq.UDP_tbGolosinas_Update";
        public static string UDP_Golosinas_Delete = "parq.UDP_tbGolosinas_Delete";

        #endregion 

        #region Insumos Quioscos
        public static string UDP_InsumosQuiosco_List = "parq.UDP_VW_tbInsumosQuiosco_Select";
        public static string UDP_InsumosQuiosco_Find = "parq.UDP_VW_tbInsumosQuiosco_Find";
        public static string UDP_InsumosQuiosco_Insert = "parq.UDP_tbInsumosQuiosco_Insert";
        //public static string UDP_InsumosQuiosco_Update = "";
        public static string UDP_InsumosQuiosco_Delete = "parq.UDP_tbInsumosQuiosco_Delete";
        public static string UDP_InsumosQuiosco_InsumosByQuiosco = "parq.UDP_VW_tbInsumosQuiosco_SelectGolosinasByQuiosco";

        #endregion

        #region Ratings
        public static string UDP_Ratings_Insert = "parq.UDP_tbRatings_Insert";

        #endregion

        #region Ventas Quiosco
        public static string UDP_VentasQuiosco_List = "fact.UDP_VW_tbVentasQuiosco_Select";
        public static string UDP_VentasQuiosco_Insert = "fact.UDP_tbVentasQuiosco_Insert";
        public static string UDP_VentasQuiosco_Find = "fact.UDP_VW_tbVentasQuiosco_Find";
        #endregion

        #region Ventas Quiosco Detalles
        public static string UDP_VentasQuioscoDetalle_List = "fact.UDP_VW_tbVentasQuioscoDetalle_Select";
        public static string UDP_VentasQuioscoDetalle_Insert = "fact.UDP_tbVentasQuioscoDetalle_Insert";
        public static string UDP_VentasQuioscoDetalle_DetalleByVenta = "fact.UDP_VW_VentasQuioscoDetalle_DetalleByVenta";
        public static string UDP_VentasQuioscoDetalle_DeleteInsumo = "fact.UDP_tbVentasQuioscoDetalle_DeleteInsumo";
        #endregion

        #region LOGIN
        public static string UDP_Usuarios_LOGIN = "acce.UDP_tbUsuarios_LOGIN";
        public static string UDP_Usuarios_MENU = "acce.UDP_tbPantallasPorRol_MENU";

        #endregion

        #region Usuarios
        public static string UDP_Usuario_INDEX   = "acce.UDP_tbUsuarios_INDEX";
        public static string UDP_Usuarios_FIND   = "acce.UDP_tbUsuarios_FIND";
        public static string UDP_Usuario_INSERT  = "acce.UDP_tbUsuarios_INSERT";
        public static string UDP_Usuarios_UPDATE = "acce.UDP_tbUsuarios_UPDATE";
        public static string UDP_Usuarios_DELETE = "acce.UDP_tbUsuarios_DELETE";
        public static string UDP_Usuarios_PASS   = "acce.UDP_tbUsuarios_Pass";

        #endregion

        #region Roles
        public static string INDEX_ROLES = "acce.UDP_tbRoles_INDEX";
        public static string FIND_ROLES = "acce.UDP_tbRoles_FIND";
        public static string INSERT_ROLES = "acce.UDP_tbRoles_INSERT";
        public static string UPDATE_ROLES = "acce.UDP_tbRoles_UPDATE";
        public static string DELETE_ROLES = "acce.UDP_tbRoles_DELETE";
        #endregion

        #region Pantallas Por Rol
        public static string INDEX_PANTALLASROL = "acce.UDP_tbPantallasPorRol_INDEX";
        public static string FIND_PANTALLASROL = "acce.UDP_tbPantallasPorRol_FIND";
        public static string INSERT_PANTALLASROL = "acce.UDP_tbPantallasPorRol_INSERT";
        public static string UPDATE_PANTALLASROL = "acce.UDP_tbPantallasPorRol_UPDATE";
        public static string DELETE_PANTALLASROL = "acce.UDP_tbPantallasPorRol_DELETE";
        public static string DELETE_PANTALLASROLES = "acce.UDP_tbPantallasPorRol_DELETE_TOTAL";

        public static string UDP_tbPantallasPorRol_Checked = "acce.UDP_tbPantallasPorRol_CHECKED";
        #endregion

        #region Pantallas
        public static string INDEX_PANTALLAS = "acce.UDP_tbPantallas_INDEX";
        public static string FIND_PANTALLAS = "acce.UDP_tbPantallas_FIND";
        public static string INSERT_PANTALLAS = "acce.UDP_tbPantallas_INSERT";
        public static string UPDATE_PANTALLAS = "acce.UDP_tbPantallas_UPDATE";
        public static string DELETE_PANTALLAS = "acce.UDP_tbPantallas_DELETE";
        #endregion

        #region Departementos
        public static string INDEX_DEPARTAMENTOS = "gral.UDP_tbDepartamentos_INDEX";
        public static string FIND_DEPARTAMENTOS = "gral.UDP_tbDepartamentos_FIND";
        public static string INSERT_DEPARTAMENTOS = "gral.UDP_tbDepartamentos_INSERT";
        public static string UPDATE_DEPARTAMENTOS = "gral.UDP_tbDepartamentos_UPDATE";
        public static string DELETE_DEPARTAMENTOS = "gral.UDP_tbDepartamentos_DELETE";
        #endregion

        #region Estados Civiles
        public static string INDEX_ESTADOSCIVILES = "gral.UDP_tbEstadosCiviles_INDEX";
        public static string FIND_ESTADOSCIVILES = "gral.UDP_tbEstadosCiviles_FIND";
        public static string INSERT_ESTADOSCIVILES = "gral.UDP_tbEstadosCiviles_INSERT";
        public static string UPDATE_ESTADOSCIVILES = "gral.UDP_tbEstadosCiviles_UPDATE";
        public static string DELETE_ESTADOSCIVILES = "gral.UDP_tbEstadosCiviles_DELETE";
        #endregion

        #region Métodos de Pago 
        public static string INDEX_METODOS = "gral.UDP_tbMetodosPago_List";
        public static string FIND_METODOS = "fact.UDP_tbMetodosPagos_FIND";
        public static string INSERT_METODOS = "fact.UDP_tbMetodosPagos_INSERT";
        public static string UPDATE_METODOS = "fact.UDP_tbMetodosPagos_UPDATE";
        public static string DELETE_METODOS = "fact.UDP_tbMetodosPagos_DELETE";
        #endregion

        #region Municipios
        public static string INDEX_MUNICIPIOS = "gral.UDP_tbMunicipios_INDEX";
        public static string FIND_MUNICIPIOS = "gral.UDP_tbMunicipios_FIND";
        public static string INSERT_MUNICIPIOS = "gral.UDP_tbMunicipios_INSERT";
        public static string UPDATE_MUNICIPIOS = "gral.UDP_tbMunicipios_UPDATE";
        public static string DELETE_MUNICIPIOS = "gral.UDP_tbMunicipios_DELETE";
        public static string FILTRAR_MUNICIPIOS = "gral.UDP_tbMunicipios_FILTER";
        #endregion

        #region Historial Visitantes Atraccion
        public static string UDP_GetChartData = "fila.UDP_VW_tbHistorialVisitantesAtraccion_GraphicData ";
        #endregion

        #region Filas
        public static string UDP_FilasPosiciones_SELECT             = "fila.UDP_tbFilasPosiciones_SELECT";
        public static string UDP_FilasPosiciones_INSERT             = "fila.UDP_tbFilasPosiciones_INSERT";
        public static string UDP_FilasPosiciones_DELETE_COMPLETO    = "fila.UDP_tbFilasPosiciones_DELETE_COMPLETO";
        public static string UDP_FilasPosiciones_DELETE             = "fila.UDP_tbFilasPosiciones_DELETE";
        #endregion

        #region Temporizadores
        public static string UDP_Temporizadores_SELECT          = "fila.UDP_tbTemporizadores_SELECT";
        public static string UDP_Temporizadores_INSERT          = "fila.UDP_tbTemporizadores_INSERT";
        public static string UDP_Temporizadores_EXTENDER        = "fila.UDP_tbTemporizadores_EXTENDER";
        public static string UDP_Temporizadores_DELETE_COMPLETO = "fila.UDP_tbTemporizadores_DELETE_COMPLETO";
        public static string UDP_Temporizadores_DELETE          = "fila.UDP_tbTemporizadores_DELETE";
        #endregion
    }
}
