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
    public class VentasQuioscoDetalleController : ControllerBase
    {
        private readonly FacturacionServices _facturacionServices;
        private readonly IMapper _mapper;

        public VentasQuioscoDetalleController(FacturacionServices facturacionServices, IMapper mapper)
        {
            _facturacionServices = facturacionServices;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult List()
        {
            var listado = _facturacionServices.ListadoVentaDetalle();
            return Ok(listado);
        }
        
        [HttpPost("DetallesPorVenta/{id}")]
        public IActionResult DetallesByVentas(int id)
        {
            var listado = _facturacionServices.DetallesByVenta(id);
            return Ok(listado);
        }


        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] VentasQuioscoDetalleViewModel data)
        {
            var item = _mapper.Map<tbVentasQuioscoDetalle>(data);
            var respuesta = _facturacionServices.InsertVentaDetalle(item);
            return Ok(respuesta);
        }

        [HttpPost("EliminarInsumo")]
        public IActionResult DeleteInsumo([FromBody] VentasQuioscoDetalleViewModel data)
        {
            var item = _mapper.Map<tbVentasQuioscoDetalle>(data);
            var respuesta = _facturacionServices.DeleteInsumo(item);
            return Ok(respuesta);
        }
    }
}
