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
    public class UsuariosController : Controller
    {
        private readonly AccessService _accessService;
        private readonly IMapper _mapper;

        public UsuariosController(AccessService accessService, IMapper mapper)
        {
            _accessService = accessService;
            _mapper = mapper;
        }


        [HttpGet("Listado")]
        public IActionResult ListUsuario()
        {
            var list = _accessService.ListUsuarios();

            return Ok(list);
        }

        [HttpPost("Insertar")]
        public IActionResult Insert([FromBody] UsuariosViewModel usuarios)
        {

            var item = _mapper.Map<tbUsuarios>(usuarios);
            var response = _accessService.InsertUsuario(item);
            return Ok(response);
        }

        [HttpPut("Actualizar")]
        public IActionResult UpdateUsuario([FromBody] UsuariosViewModel Usuario)
        {
            var item = _mapper.Map<tbUsuarios>(Usuario);
            var result = _accessService.UpdateUsuario(item);
            return Ok(result);
        }


        [HttpPut("Eliminar")]
        public IActionResult Delete(int id)
        {
          
            var result = _accessService.DeleteUsuario(id);
            return Ok(result);
        }


        [HttpGet("Login")]
        public IActionResult Login(string username, string password)
        {
            var list = _accessService.Login(username, password);
            return Ok(list);
        }

        [HttpGet("Menu")]
        public IActionResult Menu(int id)
        {
            var list = _accessService.Menu(id);
            return Ok(list);
        }
    }
}
