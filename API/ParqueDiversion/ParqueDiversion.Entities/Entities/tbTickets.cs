﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbTickets
    {
        public tbTickets()
        {
            tbTicketsCliente = new HashSet<tbTicketsCliente>();
        }

        public int tckt_ID { get; set; }
        public string tckt_Nombre { get; set; }
        public int? tckt_Precio { get; set; }
        public int? tckt_Habilitado { get; set; }
        public int? tckt_Estado { get; set; }
        public int? tckt_UsuarioCreador { get; set; }
        public DateTime? tckt_FechaCreacion { get; set; }
        public int? tckt_UsuarioModificador { get; set; }
        public DateTime? tckt_FechaModificacion { get; set; }

        public virtual ICollection<tbTicketsCliente> tbTicketsCliente { get; set; }
    }
}