using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class QuioscosViewModel
    {
        public int quio_ID { get; set; }
        public string area_Nombre { get; set; }
        public string area_Imagen { get; set; }
        public string quio_Nombre { get; set; }
        public int? area_ID { get; set; }
        public int? empl_ID { get; set; }
        public string empl_Nombres { get; set; }
        public string empl_Apellidos { get; set; }
        public string empl_NombreCompleto { get; set; }
        public int? carg_ID { get; set; }
        public string carg_Nombre { get; set; }
        public int? regi_ID { get; set; }
        public string regi_Nombre { get; set; }
        public string quio_ReferenciaUbicacion { get; set; }
        public string quio_Imagen { get; set; }
        public int? quio_Habilitado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? quio_Estado { get; set; }
        public int? quio_UsuarioCreador { get; set; }
        public string quio_UsuarioCreador_Nombre { get; set; }
        public DateTime? quio_FechaCreacion { get; set; }
        public int? quio_UsuarioModificador { get; set; }
        public string quio_UsuarioModificador_Nombre { get; set; }
        public DateTime? quio_FechaModificacion { get; set; }
    }
}
