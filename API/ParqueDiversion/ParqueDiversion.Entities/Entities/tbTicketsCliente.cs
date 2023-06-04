﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbTicketsCliente
    {
        public tbTicketsCliente()
        {
            tbFilasPosiciones = new HashSet<tbFilasPosiciones>();
            tbHistorialFilasPosiciones = new HashSet<tbHistorialFilasPosiciones>();
            tbTemporizadores = new HashSet<tbTemporizadores>();
            tbVisitantesAtraccion = new HashSet<tbVisitantesAtraccion>();
        }

        public int ticl_ID { get; set; }
        public int? tckt_ID { get; set; }
        public int? clie_ID { get; set; }
        public int? ticl_Cantidad { get; set; }
        public DateTime? ticl_FechaCompra { get; set; }
        public DateTime? ticl_FechaUso { get; set; }
        public int? ticl_Habilitado { get; set; }
        public int? ticl_Estado { get; set; }
        public int? ticl_UsuarioCreador { get; set; }
        public DateTime? ticl_FechaCreacion { get; set; }
        public int? ticl_UsuarioModificador { get; set; }
        public DateTime? ticl_FechaModificacion { get; set; }
        public int? pago_ID { get; set; }

        public virtual tbClientes clie { get; set; }
        public virtual tbMetodosPago pago { get; set; }
        public virtual tbTickets tckt { get; set; }
        public virtual ICollection<tbFilasPosiciones> tbFilasPosiciones { get; set; }
        public virtual ICollection<tbHistorialFilasPosiciones> tbHistorialFilasPosiciones { get; set; }
        public virtual ICollection<tbTemporizadores> tbTemporizadores { get; set; }
        public virtual ICollection<tbVisitantesAtraccion> tbVisitantesAtraccion { get; set; }
    }
}