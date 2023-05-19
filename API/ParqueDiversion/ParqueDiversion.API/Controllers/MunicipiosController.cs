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
    public class MunicipiosController : Controller
    {
        private readonly GeneralesServices _generalServices;
        private readonly IMapper _mapper;

        public MunicipiosController(GeneralesServices generalServices, IMapper mapper)
        {
            _generalServices = generalServices;
            _mapper = mapper;
        }


        [HttpGet("Index")]
        public IActionResult ListMunicipios()
        {
            var list = _generalServices.ListMunicipios();

            return Ok(list);
        }

        [HttpPost("ListarMunisDeptos")]
        public IActionResult ListarMunisDeptos(MunicipiosViewModel municipiosViewModel)
        {
            var item2 = _mapper.Map<tbMunicipios>(municipiosViewModel);
            var list = _generalServices.ListarMunicipiosPorDepto(item2);
            return Ok(list);
        }

        [HttpPost("Insert")]
        public IActionResult InsertMunicipios([FromBody] MunicipiosViewModel municipios)
        {

            var item = _mapper.Map<tbMunicipios>(municipios);
            var response = _generalServices.InsertMunicipios(item);
            return Ok(response);
        }

        [HttpPut("Update")]
        public IActionResult UpdateMunicipios([FromBody] MunicipiosViewModel municipios)
        {
            var item = _mapper.Map<tbMunicipios>(municipios);
            var result = _generalServices.UpdateMunicipios(item);
            return Ok(result);
        }


        [HttpPut("Delete")]
        public IActionResult DeleteMunicipios(int id)
        {
            var result = _generalServices.DeleteMunicipios(id);
            return Ok(result);
        }
    }
}
