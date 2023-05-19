using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class ClientesRegistradosViewModel
    {
        public int clre_ID { get; set; }
        public int? clie_ID { get; set; }
        public string clie_Nombres { get; set; }
        public string clre_Usuario { get; set; }
        public string clre_Email { get; set; }
        public string clre_Clave { get; set; }
        public int? clre_Habilitado { get; set; }
        public int? clre_Estado { get; set; }
        public int? clre_UsuarioCreador { get; set; }
        public string usu_Creador { get; set; }
        public DateTime? clre_FechaCreacion { get; set; }
        public int? clre_UsuarioModificador { get; set; }
        public string usu_Modificador { get; set; }
        public DateTime? clre_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
