﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace ParqueDiversion.Entities.Entities
{
    public partial class tbEmpleados
    {
        public tbEmpleados()
        {
            tbQuioscos = new HashSet<tbQuioscos>();
        }

        public int empl_ID { get; set; }
        public string empl_PrimerNombre { get; set; }
        public string empl_SegundoNombre { get; set; }
        public string empl_PrimerApellido { get; set; }
        public string empl_SegundoApellido { get; set; }
        public string empl_DNI { get; set; }
        public string empl_Email { get; set; }
        public string empl_Telefono { get; set; }
        public string empl_Sexo { get; set; }
        public int? civi_ID { get; set; }
        public int? carg_ID { get; set; }
        public int? empl_Habilitado { get; set; }
        public int? empl_Estado { get; set; }
        public int? empl_UsuarioCreador { get; set; }
        public DateTime? empl_FechaCreacion { get; set; }
        public int? empl_UsuarioModificador { get; set; }
        public DateTime? empl_FechaModificacion { get; set; }

        public virtual tbCargos carg { get; set; }
        public virtual tbEstadosCiviles civi { get; set; }
        public virtual ICollection<tbQuioscos> tbQuioscos { get; set; }
    }
}