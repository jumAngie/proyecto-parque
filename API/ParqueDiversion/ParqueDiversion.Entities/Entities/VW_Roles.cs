﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class VW_Roles
    {
        public int role_Id { get; set; }
        public string role_Nombre { get; set; }
        public int? role_Cantidad_Usuarios { get; set; }
        public int? role_Estado { get; set; }
        public int? role_UsuarioCreador { get; set; }
        public string empl_crea { get; set; }
        public DateTime? role_FechaCreacion { get; set; }
        public int? role_UsuarioModificador { get; set; }
        public string empl_Modifica { get; set; }
        public DateTime? role_FechaModificacion { get; set; }
    }
}