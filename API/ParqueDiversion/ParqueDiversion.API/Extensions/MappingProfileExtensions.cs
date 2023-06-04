using AutoMapper;
using ParqueDiversion.API.Models;
using ParqueDiversion.API.Models.Fila;
using ParqueDiversion.API.Models.Park;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Extensions
{
    public class MappingProfileExtensions : Profile
    {
        public MappingProfileExtensions()
        {
            #region Parque
            CreateMap<AreasViewModel, tbAreas>().ReverseMap();
            CreateMap<AtraccionesViewModel, tbAtracciones>().ReverseMap();
            CreateMap<CargoViewModel, tbCargos>().ReverseMap();
            CreateMap<ClientesRegistradosViewModel, tbClientesRegistrados>().ReverseMap();
            CreateMap<ClientesViewModel, tbClientes>().ReverseMap();
            CreateMap<RegionesViewModel, tbRegiones>().ReverseMap();
            CreateMap<TicketClienteViewModel, tbTicketsCliente>().ReverseMap();
            CreateMap<TicketViewModel, tbTickets>().ReverseMap();
            CreateMap<EmpleadosViewModel, tbEmpleados>().ReverseMap();
            CreateMap<QuioscosViewModel, tbQuioscos>().ReverseMap();
            CreateMap<GolosinasViewModel, tbGolosinas>().ReverseMap();
            CreateMap<InsumosQuioscoViewModel, tbInsumosQuiosco>().ReverseMap();
            CreateMap<RatingsViewModel, tbRatings>().ReverseMap();
            CreateMap<TicketsClienteFullInsertViewModel, VW_tbTicketsClienteForInsert>().ReverseMap();
            #endregion

            #region Facturación
            CreateMap<VentasQuioscoViewModel, tbVentasQuiosco>().ReverseMap();
            CreateMap<VentasQuioscoDetalleViewModel, tbVentasQuioscoDetalle>().ReverseMap();
            #endregion

            #region Acceso
            CreateMap<RolesViewModel, tbRoles>().ReverseMap();
            CreateMap<RolesXPantallaViewModel, tbRolesXPantallas>().ReverseMap();
            CreateMap<UsuariosViewModel, tbUsuarios>().ReverseMap();
            #endregion

            #region Generales
            CreateMap<MunicipiosViewModel, tbMunicipios>().ReverseMap();
            CreateMap<DepartamentosViewModel, tbDepartamentos>().ReverseMap();
            CreateMap<EstadosCivilesViewModel, tbEstadosCiviles>().ReverseMap();
            #endregion

            #region Filas
            CreateMap<HistorialVisitantesAtraccionViewModel, tbHistorialVisitantesAtraccion>().ReverseMap();
            #endregion
        }
    }
}
