using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class RatingsViewModel
    {
        public int rati_ID { get; set; }
        public int? atra_ID { get; set; }
        public int? clie_ID { get; set; }
        public int? rati_Estrellas { get; set; }
        public string rati_Comentario { get; set; }
        public int? rati_Habilitado { get; set; }
        public int? rati_Estado { get; set; }
        public int? rati_UsuarioCreador { get; set; }
        public DateTime? rati_FechaCreacion { get; set; }
        public int? rati_UsuarioModificador { get; set; }
        public DateTime? rati_FechaModificacion { get; set; }
    }
}
