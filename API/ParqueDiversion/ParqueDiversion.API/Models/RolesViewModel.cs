using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class RolesViewModel
    {
        public int role_Id { get; set; }
        public string role_Nombre { get; set; }
        public int? role_Estado { get; set; }
        public int? role_UsuarioCreador { get; set; }
        public string empl_crea { get; set; }
        public DateTime? role_FechaCreacion { get; set; }
        public int? role_UsuarioModificador { get; set; }
        public string empl_Modifica { get; set; }
        public DateTime? role_FechaModificacion { get; set; }
    }
}
