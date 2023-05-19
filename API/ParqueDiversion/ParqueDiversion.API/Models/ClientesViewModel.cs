﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class ClientesViewModel
    {
        public int clie_ID { get; set; }
        public string clie_Nombres { get; set; }
        public string clie_Apellidos { get; set; }
        public string clie_DNI { get; set; }
        public string clie_Sexo { get; set; }
        public string clie_Telefono { get; set; }
        public int? clie_Habilitado { get; set; }
        public int? clie_Estado { get; set; }
        public int? clie_UsuarioCreador { get; set; }
        public string usu_Creador { get; set; }
        public DateTime? clie_FechaCreacion { get; set; }
        public int? clie_UsuarioModificador { get; set; }
        public string usu_Modificador { get; set; }
        public DateTime? clie_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }


}
