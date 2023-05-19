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
    public class ClientesController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public ClientesController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.ClientesList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(ClientesViewModel item)
        {
            var listado = _mapper.Map<tbClientes>(item);
            var result = _parqueServices.InsertarClientes(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindClientes(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(ClientesViewModel item)
        {
            var listado = _mapper.Map<tbClientes>(item);
            var Result = _parqueServices.UpdateClientes(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarClientes(id);
            return Ok(listado);
        }
    }
}
