﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbHistorialVisitantesAtraccion
    {
        public int hiat_ID { get; set; }
        public int? atra_ID { get; set; }
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