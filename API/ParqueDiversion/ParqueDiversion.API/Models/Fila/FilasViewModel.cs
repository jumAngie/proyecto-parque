using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models.Fila
{
    public class FilasViewModel
    {
        public int fiat_ID { get; set; }
        public int? tifi_ID { get; set; }
        public string tifi_Nombre { get; set; }
        public int? atra_ID { get; set; }
        public string atra_Nombre { get; set; }
        public int fipo_ID { get; set; }
        public int? ticl_ID { get; set; }
        public string fipo_HoraIngreso { get; set; }
        public int posicion { get; set; }


    }
}
