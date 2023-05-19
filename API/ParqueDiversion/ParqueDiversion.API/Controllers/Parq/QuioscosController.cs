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
    public class QuioscosController : ControllerBase
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public QuioscosController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult List()
        {
            var listado = _parqueServices.ListadoQuiosco();
            return Ok(listado);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] QuioscosViewModel data)
        {
            var item = _mapper.Map<tbQuioscos>(data);
            var respuesta = _parqueServices.InsertQuiosco(item);
            return Ok(respuesta);
        }

        [HttpPost("Actualizar")]
        public IActionResult Update([FromBody] QuioscosViewModel data)
        {
            var item = _mapper.Map<tbQuioscos>(data);
            var respuesta = _parqueServices.UpdateQuiosco(item);
            return Ok(respuesta);
        }

        [HttpPost("Delete")]
        public IActionResult Delete([FromBody] QuioscosViewModel data)
        {
            var item = _mapper.Map<tbQuioscos>(data);
            var respuesta = _parqueServices.DeleteQuiosco(item);
            return Ok(respuesta);
        }
    }
}
