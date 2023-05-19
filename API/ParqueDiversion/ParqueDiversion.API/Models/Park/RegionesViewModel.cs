using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class RegionesViewModel
    {
        public int regi_ID { get; set; }
        public string regi_Nombre { get; set; }
        public int? regi_Habilitado { get; set; }
        public int? regi_Estado { get; set; }
        public int? regi_UsuarioCreador { get; set; }
        public string usu_Creador { get; set; }
        public DateTime? regi_FechaCreacion { get; set; }
        public int? regi_UsuarioModificador { get; set; }
        public string usu_Modificador { get; set; }
        public DateTime? regi_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
