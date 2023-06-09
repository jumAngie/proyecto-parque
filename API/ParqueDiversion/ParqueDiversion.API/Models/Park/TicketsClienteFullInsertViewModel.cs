﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models.Park
{
    public class TicketsClienteFullInsertViewModel
    {
        public int wasSearched { get; set; }
        public int ticl_ID { get; set; }
        public int? tckt_ID { get; set; }
        public int? clie_ID { get; set; }
        public string clie_Nombres { get; set; }
        public string clie_Apellidos { get; set; }
        public string clie_DNI { get; set; }
        public string clie_Sexo { get; set; }
        public string clie_Telefono { get; set; }
        public int? ticl_Cantidad { get; set; }
        public int? pago_ID { get; set; }
        public DateTime? ticl_FechaUso { get; set; }
        public int? ticl_UsuarioCreador { get; set; }
        public int? ticl_UsuarioModificador { get; set; }
    }
}
