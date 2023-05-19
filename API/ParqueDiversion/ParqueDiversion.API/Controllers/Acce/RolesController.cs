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
    public class RolesController : Controller
    {

        private readonly AccessService _accessService;
        private readonly IMapper _mapper;

        public RolesController(AccessService accessService, IMapper mapper)
        {
            _accessService = accessService;
            _mapper = mapper;
        }


        [HttpGet("Listado")]
        public IActionResult ListRol()
        {
            var list = _accessService.ListRoles();

            return Ok(list);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] RolesViewModel Roles)
        {

            var item = _mapper.Map<tbRoles>(Roles);
            var response = _accessService.InsertRol(item);
            return Ok(response);
        }

        [HttpPut("Actualizar")]
        public IActionResult Update([FromBody] RolesViewModel Rol)
        {
            var item = _mapper.Map<tbRoles>(Rol);
            var result = _accessService.UpdateRol(item);
            return Ok(result);
        }

        [HttpPut("Eliminar")]
        public IActionResult Delete(int id)
        {
         
            var result = _accessService.DeleteRol(id);
            return Ok(result);
        }


    }
}
