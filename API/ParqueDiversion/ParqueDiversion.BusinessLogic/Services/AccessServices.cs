using Paqueteria.BusinessLogic;
using ParqueDiversion.DataAccess;
using ParqueDiversion.DataAccess.Repositories;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.BusinessLogic.Services
{
    public class AccessService
    {
        private readonly UsuariosRepository _usuarioRepository;
        private readonly RolesRepository _rolesRepository;
        private readonly PantallasRepository _pantallasRepository;



        public AccessService
        (
            UsuariosRepository usuarioRepository,
            RolesRepository rolesRepository,
            PantallasRepository pantallasRepository
        )
        {
            _usuarioRepository = usuarioRepository;
            _rolesRepository = rolesRepository;
            _pantallasRepository = pantallasRepository;
        }

        #region LOGIN
        public VW_Usuarios Login(string username, string password)
        {
            var result = new ServiceResult();

            var list = _usuarioRepository.Login(username, password);
            return list;
        }

        public IEnumerable<VW_Pantallas> Menu(int id)
        {
            var result = new ServiceResult();

            var list = _usuarioRepository.Menu(id);
            return list;
        }
        #endregion

        #region Usuarios

        //INDEX
        public IEnumerable<VW_Usuarios> ListUsuarios()
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.List();
                return list;
            }
            catch (Exception e)
            {
                return (IEnumerable<VW_Usuarios>)result.Error(e.Message);
            }
        }


        //INSERT
        public ServiceResult InsertUsuario(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _usuarioRepository.Insert(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        //FIND
        public VW_Usuarios FindUsuario(int id)
        {
            var result = new ServiceResult();

            var list = _usuarioRepository.Find(id);
            return list;
        }

        public ServiceResult UpdateUsuario(tbUsuarios item)
        {
            var result = new ServiceResult();

            try
            {
                var map = _usuarioRepository.Update(item);

                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult DeleteUsuario(int id)
        {
            var result = new ServiceResult();
            try
            {
                var map = _usuarioRepository.Delete(id);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }

        }
        #endregion

        #region Roles

        //INDEX
        public IEnumerable<VW_Roles> ListRoles()
        {
            var result = new ServiceResult();
            try
            {
                var list = _rolesRepository.List();
                return list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_Roles>();
            }
        }


        //INSERT
        public IEnumerable<RequestStatus> InsertRol(tbRoles item)
        {
            var result = new ServiceResult();
            try
            {
                var list = _rolesRepository.InsertYId(item);
                return (IEnumerable<RequestStatus>)list;
            }
            catch (Exception ex)
            {
                _ = ex.Message;
                return Enumerable.Empty<RequestStatus>();
            }
        }

       

        public ServiceResult UpdateRol(tbRoles item)
        {
            var result = new ServiceResult();

            try
            {
                var map = _rolesRepository.Update(item);

                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult DeleteRol(int item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _rolesRepository.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }

        }
        #endregion

        #region Pantallas


        //INDEX
        public IEnumerable<VW_Pantallas> ListPantallas()
        {
            var result = new ServiceResult();
            try
            {
                var list = _pantallasRepository.List();
                return (IEnumerable<VW_Pantallas>)list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_Pantallas>();
            }
        }

        #endregion

        #region PantallasPorRol
        public ServiceResult PantallasAgg(int role_Id, int pant_Id, int pantrol_UserCrea)
        {
            var result = new ServiceResult();

            try
            {
                var list = _pantallasRepository.InsertP(role_Id, pant_Id, pantrol_UserCrea);
                if(list.CodeStatus==200)
                return result.SetMessage(list.MessageStatus, ServiceResultType.Success);
                else
                    return result.Error(list.MessageStatus);

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult PantallasElim(int role_Id, int pant_Id, int pantrol_UserCrea)
        {
            var result = new ServiceResult();
            try
            {
                var list = _pantallasRepository.DeleteP(role_Id, pant_Id, pantrol_UserCrea);
                if (list.CodeStatus == 200)
                    return result.SetMessage(list.MessageStatus, ServiceResultType.Success);
                else
                    return result.Error(list.MessageStatus);

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public IEnumerable<VW_Pantallas> PantallasPorRol_Checked(int role_Id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _pantallasRepository.PantallasPorRol_Checked(role_Id);
                return (IEnumerable<VW_Pantallas>)list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_Pantallas>();
            }
        }
        #endregion
    }
}
