﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Models
{
    public class EmpleadosViewModel
    {
        public int empl_ID { get; set; }
        public string empl_PrimerNombre { get; set; }
        public string empl_SegundoNombre { get; set; }
        public string empl_PrimerApellido { get; set; }
        public string empl_SegundoApellido { get; set; }
        public string empl_Nombres { get; set; }
        public string empl_Apellidos { get; set; }
        public string empl_NombreCompleto { get; set; }
        public string empl_DNI { get; set; }
        public string empl_Email { get; set; }
        public string empl_Telefono { get; set; }
        public string empl_Sexo { get; set; }
        public int? civi_ID { get; set; }
        public string civi_Descripcion { get; set; }
        public int? carg_ID { get; set; }
        public string carg_Nombre { get; set; }
        public int? empl_Habilitado { get; set; }
        public string empl_crea { get; set; }
        public string empl_modifica { get; set; }
        public int? empl_Estado { get; set; }
        public int? empl_UsuarioCreador { get; set; }
        public string empl_UsuarioCreador_Nombre { get; set; }
        public DateTime? empl_FechaCreacion { get; set; }
        public int? empl_UsuarioModificador { get; set; }
        public string empl_UsuarioModificador_Nombre { get; set; }
        public DateTime? empl_FechaModificacion { get; set; }
    }
}
