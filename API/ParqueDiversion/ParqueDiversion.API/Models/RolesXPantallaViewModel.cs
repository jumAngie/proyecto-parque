using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class RolesXPantallaViewModel
    {
        public int ropa_ID { get; set; }
        public int? role_ID { get; set; }
        public int? pant_ID { get; set; }
        public int? ropa_Estado { get; set; }
        public int? ropa_UsuarioCreador { get; set; }
        public DateTime? ropa_FechaCreacion { get; set; }
        public int? ropa_UsuarioModificador { get; set; }
        public DateTime? ropa_FechaModificacion { get; set; }

    }
}
