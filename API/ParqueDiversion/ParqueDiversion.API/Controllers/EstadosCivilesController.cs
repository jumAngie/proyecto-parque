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
    public class EstadosCivilesController : Controller
    {
        private readonly GeneralesServices _generalServices;
        private readonly IMapper _mapper;

        public EstadosCivilesController(GeneralesServices generalServices, IMapper mapper)
        {
            _generalServices = generalServices;
            _mapper = mapper;
        }


        [HttpGet("Index")]
        public IActionResult ListEstadosCiviles()
        {
            var list = _generalServices.ListEstadosCiviles();

            return Ok(list);
        }

        [HttpPost("Insert")]
        public IActionResult InsertEstadosCiviles([FromBody] EstadosCivilesViewModel estadosCiviles)
        {

            var item = _mapper.Map<tbEstadosCiviles>(estadosCiviles);
            var response = _generalServices.InsertEstadosCiviles(item);
            return Ok(response);
        }

        [HttpPut("Update")]
        public IActionResult UpdateEstadosCiviles([FromBody] EstadosCivilesViewModel estadosCiviles)
        {
            var item = _mapper.Map<tbEstadosCiviles>(estadosCiviles);
            var result = _generalServices.UpdateEstadosCiviles(item);
            return Ok(result);
        }


        [HttpPut("Delete")]
        public IActionResult DeleteEstadosCiviles(int id)
        {

            var result = _generalServices.DeleteEstadosCiviles(id);
            return Ok(result);
        }
    }
}
