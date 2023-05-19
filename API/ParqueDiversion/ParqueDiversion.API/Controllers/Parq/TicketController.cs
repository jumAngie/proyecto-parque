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
    public class TicketController : Controller
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public TicketController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var listado = _parqueServices.TicketList();
            return Ok(listado);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(TicketViewModel item)
        {
            var listado = _mapper.Map<tbTickets>(item);
            var result = _parqueServices.InsertarTicket(listado);
            return Ok(result);
        }


        [HttpGet("Find/{id}")]
        public IActionResult Edit(int id)
        {
            var listado = _parqueServices.FindTicket(id);
            return Ok(listado);
        }

        [HttpPut("Update")]
        public IActionResult Edit(TicketViewModel item)
        {
            var listado = _mapper.Map<tbTickets>(item);
            var Result = _parqueServices.UpdateTicket(listado);
            return Ok(Result);
        }

        [HttpPost("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            var listado = _parqueServices.BorrarTicket(id);
            return Ok(listado);
        }
    }
}
