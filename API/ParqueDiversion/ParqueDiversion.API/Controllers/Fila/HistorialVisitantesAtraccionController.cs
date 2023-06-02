using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ParqueDiversion.API.Models.Fila;
using ParqueDiversion.BusinessLogic.Services;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Controllers.Fila
{
    [Route("api/[controller]")]
    [ApiController]
    public class HistorialVisitantesAtraccionController : ControllerBase
    {
        private readonly FilaServices _filaServices;
        private readonly IMapper _mapper;

        public HistorialVisitantesAtraccionController(
            FilaServices filaServices,
        IMapper mapper
        )
        {
            _filaServices = filaServices;
            _mapper = mapper;
        }

        [HttpPost("ChartData")]
        public IActionResult ChartData([FromBody] filterChartData item)
        {
            var result = _filaServices.GetChartData(item.fechaInicial, item.fechaFinal);
            return Ok(result);
        }

        public class filterChartData
        {
            public string fechaInicial { get; set; }
            public string fechaFinal { get; set; }
        }
    }
}
