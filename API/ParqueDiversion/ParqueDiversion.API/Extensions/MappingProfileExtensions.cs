using AutoMapper;
using ParqueDiversion.API.Models;
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
            CreateMap<EmpleadosViewModel, tbEmpleados>().ReverseMap();
            CreateMap<QuioscosViewModel, tbQuioscos>().ReverseMap();
            CreateMap<GolosinasViewModel, tbGolosinas>().ReverseMap();
            CreateMap<InsumosQuioscoViewModel, tbInsumosQuiosco>().ReverseMap();
            CreateMap<RatingsViewModel, tbRatings>().ReverseMap();
            #endregion


            #region Facturación
            CreateMap<VentasQuioscoViewModel, tbVentasQuiosco>().ReverseMap();
            CreateMap<VentasQuioscoDetalleViewModel, tbVentasQuioscoDetalle>().ReverseMap();
            #endregion
        }
    }
}
