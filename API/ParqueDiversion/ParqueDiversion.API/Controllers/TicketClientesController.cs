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
    public class TicketClientesController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public TicketClientesController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.TicketClientesList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(TicketClienteViewModel item)
        {
            var listado = _mapper.Map<tbTicketsCliente>(item);
            var result = _parqueServices.InsertarTicketClientes(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindTicketClientes(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(TicketClienteViewModel item)
        {
            var listado = _mapper.Map<tbTicketsCliente>(item);
            var Result = _parqueServices.UpdateTicketClientes(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarTicketClientes(id);
            return Ok(listado);
        }
    }
}
