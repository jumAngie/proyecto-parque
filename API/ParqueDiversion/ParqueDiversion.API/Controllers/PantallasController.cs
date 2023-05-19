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
    public class PantallasController : Controller
    {

        private readonly AccessService _accessService;
        private readonly IMapper _mapper;

        public PantallasController(AccessService accessService, IMapper mapper)
        {
            _accessService = accessService;
            _mapper = mapper;
        }


        [HttpGet("Index")]
        public IActionResult Index()
        {
            var list = _accessService.ListPantallas();

            return Ok(list);
        }

        [HttpPost("PantallasAgg")]
        public IActionResult PantallasAgg([FromBody] RolesXPantallaViewModel pr)
        {
            var item = _mapper.Map<tbRolesXPantallas>(pr);
            var result = _accessService.PantallasAgg(item);
            return Ok(result);
        }

        [HttpPost("PantallasElim")]
        public IActionResult PantallasElim([FromBody] RolesXPantallaViewModel pr)
        {

            var result = _accessService.PantallasElim((int)pr.role_ID, (int)pr.pant_ID, (int)pr.ropa_UsuarioCreador);
            return Ok(result);
        }

        [HttpPost("PantallasPorRol_Checked")]
        public IActionResult PantallasPorRol_Checked([FromBody] RolesXPantallaViewModel pr)
        {

            var result = _accessService.PantallasPorRol_Checked((int)pr.role_ID);
            return Ok(result);
        }
    }
}
