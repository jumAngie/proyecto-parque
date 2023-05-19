using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class TicketViewModel
    {
        public int tckt_ID { get; set; }
        public string tckt_Nombre { get; set; }
        public int? tckt_Precio { get; set; }
        public int? tckt_Habilitado { get; set; }
        public int? tckt_Estado { get; set; }
        public int? tckt_UsuarioCreador { get; set; }
        public string usu_Creador { get; set; }
        public DateTime? tckt_FechaCreacion { get; set; }
        public int? tckt_UsuarioModificador { get; set; }
        public int? usu_Modificador { get; set; }
        public DateTime? tckt_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
