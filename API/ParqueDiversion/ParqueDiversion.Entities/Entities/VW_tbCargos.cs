﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class VW_tbCargos
    {
        public int carg_ID { get; set; }
        public string carg_Nombre { get; set; }
        public int? carg_Habilitado { get; set; }
        public int? carg_Estado { get; set; }
        public int? carg_UsuarioCreador { get; set; }
        public string usu_Creador { get; set; }
        public DateTime? carg_FechaCreacion { get; set; }
        public int? carg_UsuarioModificador { get; set; }
        public string usu_Modificador { get; set; }
        public DateTime? carg_FechaModificacion { get; set; }
        public string empl_crea { get; set; }
        public string empl_Modifica { get; set; }
    }
}