﻿using AutoMapper;
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
    public class GolosinasController : ControllerBase
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public GolosinasController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult List()
        {
            var listado = _parqueServices.ListadoGolosina();
            return Ok(listado);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] GolosinasViewModel data)
        {
            var item = _mapper.Map<tbGolosinas>(data);
            var respuesta = _parqueServices.InsertGolosina(item);
            return Ok(respuesta);
        }

        [HttpPost("Actualizar")]
        public IActionResult Update([FromBody] GolosinasViewModel data)
        {
            var item = _mapper.Map<tbGolosinas>(data);
            var respuesta = _parqueServices.UpdateGolosina(item);
            return Ok(respuesta);
        }

        [HttpPost("Delete")]
        public IActionResult Delete([FromBody] GolosinasViewModel data)
        {
            var item = _mapper.Map<tbGolosinas>(data);
            var respuesta = _parqueServices.DeleteGolosina(item);
            return Ok(respuesta);
        }
    }
}
