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
    public class CargoController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public CargoController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }


        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.CargoList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(CargoViewModel item)
        {
            var listado = _mapper.Map<tbCargos>(item);
            var result = _parqueServices.InsertarCargos(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindCargo(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(CargoViewModel item)
        {
            var listado = _mapper.Map<tbCargos>(item);
            var Result = _parqueServices.UpdateCargo(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarCargo(id);
            return Ok(listado);
        }

    }
}
