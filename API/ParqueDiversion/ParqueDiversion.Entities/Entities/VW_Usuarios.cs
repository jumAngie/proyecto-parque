﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class VW_Usuarios
    {
        public int usua_ID { get; set; }
        public string usua_Usuario { get; set; }
        public string usua_Clave { get; set; }
        public int? empl_Id { get; set; }
        public string nombreEmpleado { get; set; }
        public bool? usua_Admin { get; set; }
        public string EsAdmin { get; set; }
        public int? role_ID { get; set; }
        public string role_Descripcion { get; set; }
        public int? usua_Estado { get; set; }
        public int? usua_UsuarioCreador { get; set; }
        public string empl_Crea { get; set; }
        public DateTime? usua_FechaCreacion { get; set; }
        public int? usua_UsuarioModificador { get; set; }
        public string empl_Modifica { get; set; }
        public DateTime? usua_FechaModificacion { get; set; }
    }
}