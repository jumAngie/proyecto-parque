using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ParqueDiversion.API.Models;
using ParqueDiversion.BusinessLogic.Services;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VentasQuioscoController : ControllerBase
    {
        private readonly FacturacionServices _facturacionServices;
        private readonly IMapper _mapper;

        public VentasQuioscoController(FacturacionServices facturacionServices, IMapper mapper)
        {
            _facturacionServices = facturacionServices;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult List()
        {
            var listado = _facturacionServices.ListadoVenta();
            return Ok(listado);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] VentasQuioscoViewModel data)
        {
            var item = _mapper.Map<tbVentasQuiosco>(data);
            var respuesta = _facturacionServices.InsertVenta(item);
            return Ok(respuesta);
        }

    }
}
