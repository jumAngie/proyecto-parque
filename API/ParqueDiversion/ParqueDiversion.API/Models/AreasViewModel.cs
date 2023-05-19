using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class AreasViewModel
    {
        public int area_ID { get; set; }
        public string area_Nombre { get; set; }
        public string area_Descripcion { get; set; }
        public int? regi_ID { get; set; }
        public string regi_Nombre { get; set; }
        public string area_UbicaionReferencia { get; set; }
        public string area_Imagen { get; set; }
        public int? area_Habilitado { get; set; }
        public int? area_Estado { get; set; }
        public int? area_UsuarioCreador { get; set; }
        public string usua_Creador { get; set; }
        public DateTime? area_FechaCreacion { get; set; }
        public int? area_UsuarioModificador { get; set; }
        public string usua_Modificar { get; set; }
        public DateTime? area_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
