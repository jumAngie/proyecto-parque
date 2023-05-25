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
    public class EmpleadosController : ControllerBase
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public EmpleadosController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult List()
        {
            var listado = _parqueServices.ListadoEmpleados();
            return Ok(listado);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] EmpleadosViewModel data)
        {
            var item = _mapper.Map<tbEmpleados>(data);
            var respuesta = _parqueServices.InsertEmpleado(item);
            return Ok(respuesta);
        }

        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindEmpleado(id);
            return Ok(listado);
        }

        [HttpPost("Actualizar")]
        public IActionResult Update([FromBody] EmpleadosViewModel data)
        {
            var item = _mapper.Map<tbEmpleados>(data);
            var respuesta = _parqueServices.UpdateEmpleados(item);
            return Ok(respuesta);
        }        
        
        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            
            var respuesta = _parqueServices.DeleteEmpleado(id);
            return Ok(respuesta);
        }

    }
}
