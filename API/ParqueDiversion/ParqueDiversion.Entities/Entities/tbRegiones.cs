﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbRegiones
    {
        public tbRegiones()
        {
            tbAreas = new HashSet<tbAreas>();
            tbAtracciones = new HashSet<tbAtracciones>();
            tbQuioscos = new HashSet<tbQuioscos>();
        }

        public int regi_ID { get; set; }
        public string regi_Nombre { get; set; }
        public int? regi_Habilitado { get; set; }
        public int? regi_Estado { get; set; }
        public int? regi_UsuarioCreador { get; set; }
        public DateTime? regi_FechaCreacion { get; set; }
        public int? regi_UsuarioModificador { get; set; }
        public DateTime? regi_FechaModificacion { get; set; }

        public virtual ICollection<tbAreas> tbAreas { get; set; }
        public virtual ICollection<tbAtracciones> tbAtracciones { get; set; }
        public virtual ICollection<tbQuioscos> tbQuioscos { get; set; }
    }
}