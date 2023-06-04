using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using ParqueDiversion.API.Models.Fila;
using ParqueDiversion.BusinessLogic.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ParqueDiversion.API.Controllers.Fila
{
    [Route("api/[controller]")]
    [ApiController]
    public class FilasController : Controller
    {
        private readonly FilaServices _filaServices;
        private readonly IMapper _mapper;

        public FilasController(
            FilaServices filaServices,
        IMapper mapper
        )
        {
            _filaServices = filaServices;
            _mapper = mapper;
        }

        [HttpGet("Listado")]
        public IActionResult Listado(int tifi_ID, int atra_ID)
        {
            var result = _filaServices.ListPosiciones((int)tifi_ID, (int)atra_ID);
            return Ok(result);
        }

        [HttpPost("Insert")]
        public IActionResult Insert(int atra_ID, string ticl_ID)
        {
            var result = _filaServices.InsertPosiciones((int)atra_ID, ticl_ID);
            return Ok(result);
        }

        [HttpDelete("DeleteCompleto")]
        public IActionResult DeleteCompleto(int atra_ID, int fiat_ID)
        {
            var result = _filaServices.DeleteCompleto((int)atra_ID, (int)fiat_ID);
            return Ok(result);
        }

        [HttpDelete("Delete")]
        public IActionResult Delete(int fipo_ID)
        {
            var result = _filaServices.Delete((int)fipo_ID);
            return Ok(result);
        }

    }
}
