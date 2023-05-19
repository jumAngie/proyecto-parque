using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class EstadosCivilesViewModel
    {

        public int civi_Id { get; set; }
        public string civi_Descripcion { get; set; }
        public int? civi_Estado { get; set; }
        public int? civi_UsuarioCreador { get; set; }
        public string empl_crea { get; set; }
        public DateTime? civi_FechaCreacion { get; set; }
        public int? civi_UsuarioModificador { get; set; }
        public string empl_Modifica { get; set; }
        public DateTime? civi_FechaModificacion { get; set; }
    }
}
