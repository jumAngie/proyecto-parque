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
    public class RatingsController : ControllerBase
    {
        private readonly ParqueServices _parqueServices;
        private readonly IMapper _mapper;

        public RatingsController(ParqueServices parqueServices, IMapper mapper)
        {
            _parqueServices = parqueServices;
            _mapper = mapper;
        }


        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] RatingsViewModel data)
        {
            var item = _mapper.Map<tbRatings>(data);
            var respuesta = _parqueServices.InsertRating(item);
            return Ok(respuesta);
        }

    }
}
