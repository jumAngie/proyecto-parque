﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tblDeporte
    {
        public tblDeporte()
        {
            tblEvento = new HashSet<tblEvento>();
        }

        public int DeporteId { get; set; }
        public string DeporteDescripcion { get; set; }
        public string DeporteCreacion { get; set; }
        public string DeporteModificacion { get; set; }
        public DateTime? DeporteFechaCreacion { get; set; }
        public DateTime? DeporteFechaModificacion { get; set; }

        public virtual ICollection<tblEvento> tblEvento { get; set; }
    }
}