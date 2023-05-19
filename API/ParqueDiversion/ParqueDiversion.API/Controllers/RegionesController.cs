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
    public class RegionesController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public RegionesController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.RegionList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(RegionesViewModel item)
        {
            var listado = _mapper.Map<tbRegiones>(item);
            var result = _parqueServices.InsertarRegiones(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindRegiones(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(RegionesViewModel item)
        {
            var listado = _mapper.Map<tbRegiones>(item);
            var Result = _parqueServices.UpdateRegiones(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarRegion(id);
            return Ok(listado);
        }
    }
}
