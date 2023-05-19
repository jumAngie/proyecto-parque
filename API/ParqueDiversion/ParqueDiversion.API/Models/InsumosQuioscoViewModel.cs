using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class InsumosQuioscoViewModel
    {
        public int insu_ID { get; set; }
        public int? quio_ID { get; set; }
        public int? area_ID { get; set; }
        public string area_Nombre { get; set; }
        public string quio_Nombre { get; set; }
        public int? empl_ID { get; set; }
        public int? regi_ID { get; set; }
        public string quio_ReferenciaUbicacion { get; set; }
        public string quio_Imagen { get; set; }
        public int? golo_ID { get; set; }
        public string golo_Nombre { get; set; }
        public int? golo_Precio { get; set; }
        public int? insu_Stock { get; set; }
        public int? insu_Habilitado { get; set; }
        public int? insu_Estado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? insu_UsuarioCreador { get; set; }
        public string insu_UsuarioCreador_Nombre { get; set; }
        public DateTime? insu_FechaCreacion { get; set; }
        public int? insu_UsuarioModificador { get; set; }
        public string insu_UsuarioModificador_Nombre { get; set; }
        public DateTime? insu_FechaModificacion { get; set; }
    }
}
