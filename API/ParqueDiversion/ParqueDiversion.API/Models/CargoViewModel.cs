using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class CargoViewModel
    {
        public int carg_ID { get; set; }
        public string carg_Nombre { get; set; }
        public int? carg_Habilitado { get; set; }
        public int? carg_Estado { get; set; }
        public int? carg_UsuarioCreador { get; set; }
        public string usu_Creador { get; set; }
        public DateTime? carg_FechaCreacion { get; set; }
        public int? carg_UsuarioModificador { get; set; }
        public string usu_Modificador { get; set; }
        public DateTime? carg_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
