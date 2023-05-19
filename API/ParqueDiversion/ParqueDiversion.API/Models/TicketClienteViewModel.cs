using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class TicketClienteViewModel
    {
        public int ticl_ID { get; set; }
        public int? tckt_ID { get; set; }
        public string tckt_Nombre { get; set; }
        public int? clie_ID { get; set; }
        public string clie_Nombres { get; set; }
        public int? ticl_Cantidad { get; set; }
        public DateTime? ticl_FechaCompra { get; set; }
        public DateTime? ticl_FechaUso { get; set; }
        public int? ticl_Habilitado { get; set; }
        public int? ticl_Estado { get; set; }
        public int? ticl_UsuarioCreador { get; set; }
        public string usu_Crea { get; set; }
        public DateTime? ticl_FechaCreacion { get; set; }
        public int? ticl_UsuarioModificador { get; set; }
        public string usu_Modifica { get; set; }
        public DateTime? ticl_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
