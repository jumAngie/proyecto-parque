using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class MunicipiosViewModel
    {

        public int? dept_Id { get; set; }
        public string dept_Codigo { get; set; }
        public string dept_Nombre { get; set; }
        public int muni_Id { get; set; }
        public string muni_Codigo { get; set; }
        public string muni_Nombre { get; set; }
        public int? muni_Estado { get; set; }
        public int? muni_UsuarioCreador { get; set; }
        public string empl_crea { get; set; }
        public DateTime? muni_FechaCreacion { get; set; }
        public int? muni_UsuarioModificador { get; set; }
        public string empl_Modifica { get; set; }
        public DateTime? muni_FechaModificacion { get; set; }
    }
}
