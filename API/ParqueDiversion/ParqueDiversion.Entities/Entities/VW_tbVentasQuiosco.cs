﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class VW_tbVentasQuiosco
    {
        public int vent_ID { get; set; }
        public int? quio_ID { get; set; }
        public string quio_Nombre { get; set; }
        public string area_Nombre { get; set; }
        public string regi_Nombre { get; set; }
        public string quio_ReferenciaUbicacion { get; set; }
        public string quio_Imagen { get; set; }
        public int? clie_ID { get; set; }
        public string clie_Nombres { get; set; }
        public string clie_Apellidos { get; set; }
        public string vent_ClienteNombreCompleto { get; set; }
        public string clie_DNI { get; set; }
        public string clie_Telefono { get; set; }
        public int? pago_ID { get; set; }
        public string pago_Nombre { get; set; }
        public int? vent_Habilitado { get; set; }
        public int? vent_Estado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? vent_UsuarioCreador { get; set; }
        public string vent_UsuarioCreador_Nombre { get; set; }
        public DateTime? vent_FechaCreacion { get; set; }
        public int? vent_UsuarioModificador { get; set; }
        public string vent_UsuarioModificador_Nombre { get; set; }
        public DateTime? vent_FechaModificacion { get; set; }
    }
}