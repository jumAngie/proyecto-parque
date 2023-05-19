using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class VentasQuioscoDetalleViewModel
    {
        public int deta_ID { get; set; }
        public int? vent_ID { get; set; }
        public int? golo_ID { get; set; }
        public string golo_Nombre { get; set; }
        public int? golo_Precio { get; set; }
        public int? deta_Cantidad { get; set; }
        public int? deta_Habilitado { get; set; }
        public int? deta_Estado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? deta_UsuarioCreador { get; set; }
        public string deta_UsuarioCreador_Nombre { get; set; }
        public DateTime? deta_FechaCreacion { get; set; }
        public int? deta_UsuarioModificador { get; set; }
        public string deta_UsuarioModificador_Nombre { get; set; }
        public DateTime? deta_FechaModificacion { get; set; }
    }
}
