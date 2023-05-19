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
    public class AreasController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public AreasController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.AreasList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(AreasViewModel item)
        {
            var listado = _mapper.Map<tbAreas>(item);
            var result = _parqueServices.InsertarAreas(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindAreas(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(AreasViewModel item)
        {
            var listado = _mapper.Map<tbAreas>(item);
            var Result = _parqueServices.UpdateAreas(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarAreas(id);
            return Ok(listado);
        }
    }
}
