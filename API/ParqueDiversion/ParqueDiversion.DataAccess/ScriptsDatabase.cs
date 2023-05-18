using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess
{
    public class ScriptsDatabase
    {

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
        public static string UDP_InsumosQuiosco_Update = "";
        public static string UDP_InsumosQuiosco_Delete = "parq.UDP_tbInsumosQuiosco_Delete";

        #endregion


        #region Ratings
        public static string UDP_Ratings_Insert = "";

        #endregion

        #region Ventas Quiosco
        public static string UDP_VentasQuiosco_Insert = "";

        #endregion
    }
}
