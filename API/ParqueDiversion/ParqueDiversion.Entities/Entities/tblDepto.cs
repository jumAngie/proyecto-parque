﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tblDepto
    {
        public tblDepto()
        {
            tblCiudades = new HashSet<tblCiudades>();
        }

        public int DeptoId { get; set; }
        public string DeptoDescricpion { get; set; }
        public string DeptoCreacion { get; set; }
        public string DeptoModificacion { get; set; }
        public DateTime? DeptoFechaCreacion { get; set; }
        public DateTime? DeptoFechaModificacion { get; set; }

        public virtual ICollection<tblCiudades> tblCiudades { get; set; }
    }
}