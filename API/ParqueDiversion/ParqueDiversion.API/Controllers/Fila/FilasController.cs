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

        //TEMPORIZADORES

        [HttpGet("ListadoTemporizadores")]
        public IActionResult ListadoTemporizadores(int listado)
        {
            var result = _filaServices.ListadoTemporizadores((int)listado);
            return Ok(result);
        }

        [HttpPost("InsertTemporizador")]
        public IActionResult InsertTemporizador(string ticl_ID, string atra_ID, string temp_Expiracion)
        {
            var result = _filaServices.InsertTempo(ticl_ID, atra_ID, temp_Expiracion);
            return Ok(result);
        }

        [HttpDelete("DeleteTemporizador")]
        public IActionResult DeleteTemporizador(int temp_ID)
        {
            var result = _filaServices.DeleteTempo(temp_ID);
            return Ok(result);
        }

        [HttpDelete("DeleteCompletoTemporizador")]
        public IActionResult DeleteCompletoTemporizador()
        {
            var result = _filaServices.DeleteTempoCompleto();
            return Ok(result);
        }

        [HttpPut("ExtenderHora")]
        public IActionResult ExtenderHora(int temp_ID,string temp_Expiracion)
        {
            var result = _filaServices.ExtenderTempo(temp_ID, temp_Expiracion);
            return Ok(result);
        }

    }
}
