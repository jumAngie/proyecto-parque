using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models.Fila
{
    public class HistorialVisitantesAtraccionViewModel
    {
        public int hiat_ID { get; set; }
        public int? atra_ID { get; set; }
        public string atra_Nombre { get; set; }
        public int? ticl_ID { get; set; }
        public TimeSpan? viat_HoraEntrada { get; set; }
        public DateTime? hiat_FechaFiltro { get; set; }
        public int? hiat_Habilitado { get; set; }
        public int? hiat_Estado { get; set; }
        public int? hiat_UsuarioCreador { get; set; }
        public DateTime? hiat_FechaCreacion { get; set; }
        public int? hiat_UsuarioModificador { get; set; }
        public DateTime? hiat_FechaModificacion { get; set; }
    }
}
