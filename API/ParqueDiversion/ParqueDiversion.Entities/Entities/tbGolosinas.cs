﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbGolosinas
    {
        public tbGolosinas()
        {
            tbInsumosQuiosco = new HashSet<tbInsumosQuiosco>();
            tbVentasQuioscoDetalle = new HashSet<tbVentasQuioscoDetalle>();
        }

        public int golo_ID { get; set; }
        public string golo_Nombre { get; set; }
        public int? golo_Precio { get; set; }
        public int? golo_Habilitado { get; set; }
        public int? golo_Estado { get; set; }
        public int? golo_UsuarioCreador { get; set; }
        public DateTime? golo_FechaCreacion { get; set; }
        public int? golo_UsuarioModificador { get; set; }
        public DateTime? golo_FechaModificacion { get; set; }

        public virtual ICollection<tbInsumosQuiosco> tbInsumosQuiosco { get; set; }
        public virtual ICollection<tbVentasQuioscoDetalle> tbVentasQuioscoDetalle { get; set; }
    }
}