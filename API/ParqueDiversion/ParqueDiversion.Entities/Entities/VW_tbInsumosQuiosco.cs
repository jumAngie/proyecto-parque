﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class VW_tbInsumosQuiosco
    {
        public int insu_ID { get; set; }
        public int? quio_ID { get; set; }
        public string quio_Nombre { get; set; }
        public int? area_ID { get; set; }
        public string quio_area_Nombre { get; set; }
        public int? empl_ID { get; set; }
        public string quio_empl_NombreCompleto { get; set; }
        public int? regi_ID { get; set; }
        public string quio_regi_Nombre { get; set; }
        public string quio_ReferenciaUbicacion { get; set; }
        public string quio_Imagen { get; set; }
        public int? golo_ID { get; set; }
        public string golo_Nombre { get; set; }
        public int? golo_Precio { get; set; }
        public int? insu_Stock { get; set; }
        public int? insu_Habilitado { get; set; }
        public int? insu_Estado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? insu_UsuarioCreador { get; set; }
        public string insu_UsuarioCreador_Nombre { get; set; }
        public DateTime? insu_FechaCreacion { get; set; }
        public int? insu_UsuarioModificador { get; set; }
        public string insu_UsuarioModificador_Nombre { get; set; }
        public DateTime? insu_FechaModificacion { get; set; }
    }
}