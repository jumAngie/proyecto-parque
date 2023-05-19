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
    public class DepartamentosController : Controller
    {
        private readonly GeneralesServices _generalServices;
        private readonly IMapper _mapper;

        public DepartamentosController(GeneralesServices generalServices, IMapper mapper)
        {
            _generalServices = generalServices;
            _mapper = mapper;
        }


        [HttpGet("Listado")]
        public IActionResult ListDepartamentos()
        {
            var list = _generalServices.ListDepartamentos();

            return Ok(list);
        }

        [HttpPost("Insertar")]
        public IActionResult InsertDepartamentos([FromBody] DepartamentosViewModel departamentos)
        {

            var item = _mapper.Map<tbDepartamentos>(departamentos);
            var response = _generalServices.InsertDepartamentos(item);
            return Ok(response);
        }

        [HttpPut("Actualizar")]
        public IActionResult UpdateDepartamentos([FromBody] DepartamentosViewModel departamentos)
        {
            var item = _mapper.Map<tbDepartamentos>(departamentos);
            var result = _generalServices.UpdateDepartamentos(item);
            return Ok(result);
        }


        [HttpPut("Eliminar")]
        public IActionResult DeleteDepartamentos(int id)
        {

            var result = _generalServices.DeleteDepartamentos(id);
            return Ok(result);
        }
    }
}
