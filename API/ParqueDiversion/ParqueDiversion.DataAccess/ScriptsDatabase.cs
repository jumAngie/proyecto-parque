using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess
{
    public class ScriptsDatabase
    {
        #region Angie Procs

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
                #endregion

                #region Atracciones
                public static string UDP_Atracciones_List = "parq.UDP_tbAtracciones_SELECT";
                public static string UDP_Atracciones_Insert = "parq.UDP_tbAtracciones_INSERT";
                public static string UDP_Atracciones_Find = "parq.UDP_tbAtracciones_FIND";
                public static string UDP_Atracciones_Update = "parq.UDP_tbAtracciones_UPDATE";
                public static string UDP_Atracciones_Delete = "parq.UDP_tbAtracciones_DELETE";
                #endregion

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

        #endregion

        #region Ratings
        public static string UDP_Ratings_Insert = "parq.UDP_tbRatings_Insert";

        #endregion

        #region Ventas Quiosco
        public static string UDP_VentasQuiosco_List = "fact.UDP_VW_tbVentasQuiosco_Select";
        public static string UDP_VentasQuiosco_Insert = "fact.UDP_tbVentasQuiosco_Insert";

        #endregion

        #region Ventas Quiosco Detalles
        public static string UDP_VentasQuioscoDetalle_List = "fact.UDP_VW_tbVentasQuioscoDetalle_Select";
        public static string UDP_VentasQuioscoDetalle_Insert = "fact.UDP_tbVentasQuioscoDetalle_Insert";
        #endregion
    }
}
