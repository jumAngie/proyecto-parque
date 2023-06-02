using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class GolosinasViewModel
    {
        public int golo_ID { get; set; }
        public string golo_Nombre { get; set; }
        public int? golo_Precio { get; set; }
        public string golo_Img { get; set; }
        public int? golo_Habilitado { get; set; }
        public int? golo_Estado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? golo_UsuarioCreador { get; set; }
        public string golo_UsuarioCreador_Nombre { get; set; }
        public DateTime? golo_FechaCreacion { get; set; }
        public string golo_UsuarioModificador_Nombre { get; set; }
        public int? golo_UsuarioModificador { get; set; }
        public DateTime? golo_FechaModificacion { get; set; }
    }
}
