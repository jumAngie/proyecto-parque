using AutoMapper;
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
    public class AtraccionesController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public AtraccionesController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.AtraccionesList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(AtraccionesViewModel item)
        {
            var listado = _mapper.Map<tbAtracciones>(item);
            var result = _parqueServices.InsertarAtracciones(listado);
            return Ok(result);
        }


        [HttpPost("Find")]
        public IActionResult Find(AtraccionesViewModel item)
        {
            var listado = _parqueServices.FindAtracciones(item.atra_ID);
            return Ok(listado);
        }

        [HttpPost("FindArea/{AreaId}")]
        public IActionResult FindAtraccionPorAreaId(int AreaId)
        {
            var listado = _parqueServices.FindAtraccionesPorArea(AreaId);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(AtraccionesViewModel item)
        {
            var listado = _mapper.Map<tbAtracciones>(item);
            var Result = _parqueServices.UpdateAtracciones(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarAtracciones(id);
            return Ok(listado);
        }
    }
}
