using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class DepartamentosViewModel
    {
        public int dept_Id { get; set; }
        public string dept_Codigo { get; set; }
        public string dept_Nombre { get; set; }
        public int? dept_Estado { get; set; }
        public int? dept_UsuarioCreador { get; set; }
        public string empl_crea { get; set; }
        public DateTime? dept_FechaCreacion { get; set; }
        public int? dept_UsuarioModificador { get; set; }
        public string empl_Modifica { get; set; }
        public DateTime? dept_FechaModificacion { get; set; }
    }
}
