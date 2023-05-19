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
    public class ClientesRegistradosController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public ClientesRegistradosController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.ClientesRegistradosList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(ClientesRegistradosViewModel item)
        {
            var listado = _mapper.Map<tbClientesRegistrados>(item);
            var result = _parqueServices.InsertarClientesRegistrados(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindClientesRegistrados(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(ClientesRegistradosViewModel item)
        {
            var listado = _mapper.Map<tbClientesRegistrados>(item);
            var Result = _parqueServices.UpdateClientesRegistrados(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarClientesRegistrados(id);
            return Ok(listado);
        }
    }
}
