﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbAreas
    {
        public tbAreas()
        {
            tbAtracciones = new HashSet<tbAtracciones>();
            tbQuioscos = new HashSet<tbQuioscos>();
        }

        public int area_ID { get; set; }
        public string area_Nombre { get; set; }
        public string area_Descripcion { get; set; }
        public int? regi_ID { get; set; }
        public string area_UbicaionReferencia { get; set; }
        public string area_Imagen { get; set; }
        public int? area_Habilitado { get; set; }
        public int? area_Estado { get; set; }
        public int? area_UsuarioCreador { get; set; }
        public DateTime? area_FechaCreacion { get; set; }
        public int? area_UsuarioModificador { get; set; }
        public DateTime? area_FechaModificacion { get; set; }

        public virtual tbRegiones regi { get; set; }
        public virtual ICollection<tbAtracciones> tbAtracciones { get; set; }
        public virtual ICollection<tbQuioscos> tbQuioscos { get; set; }
    }
}