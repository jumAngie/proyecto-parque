﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class AtraccionesViewModel
    {
        public int atra_ID { get; set; }
        public int? area_ID { get; set; }
        public string area_Descripcion { get; set; }
        public string atra_Nombre { get; set; }
        public string atra_Descripcion { get; set; }
        public int? regi_ID { get; set; }
        public string regi_Nombre { get; set; }
        public string atra_ReferenciaUbicacion { get; set; }
        public int? atra_LimitePersonas { get; set; }
        public string atra_DuracionRonda { get; set; }
        public string atra_Imagen { get; set; }
        public int? atra_Habilitado { get; set; }
        public int? atra_Estado { get; set; }
        public int? atra_UsuarioCreador { get; set; }
        public string usu_Crea { get; set; }
        public DateTime? atra_FechaCreacion { get; set; }
        public int? atra_UsuarioModificador { get; set; }
        public string usu_Modifica { get; set; }
        public DateTime? atra_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}
