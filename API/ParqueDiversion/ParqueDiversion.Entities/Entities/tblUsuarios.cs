﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tblUsuarios
    {
        public int UsuId { get; set; }
        public string UsuNombre { get; set; }
        public string UsuUsuario { get; set; }
        public string UsuClave { get; set; }
        public string UsuCreacion { get; set; }
        public string UsuModificacion { get; set; }
        public DateTime? UsuFechaCreacion { get; set; }
        public DateTime? UsuFechaModificacion { get; set; }
        public bool UsuAdmin { get; set; }
        public bool UsuEstado { get; set; }
    }
}