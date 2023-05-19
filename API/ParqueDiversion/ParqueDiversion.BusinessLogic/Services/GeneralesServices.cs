using Paqueteria.BusinessLogic;
using ParqueDiversion.DataAccess.Repositories;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.BusinessLogic.Services
{
    public class GeneralesServices
    {

        private readonly DepartamentosRepository _departamentosRepository;
        private readonly MunicipiosRepository _municipiosRepository;
        private readonly EstadosCivilesRepository _estadosCivilesRepository;


        public GeneralesServices
     (
         DepartamentosRepository departamentosRepository,
         MunicipiosRepository municipiosRepository,
         EstadosCivilesRepository estadosCivilesRepository

     )
        {
            _departamentosRepository = departamentosRepository;
            _municipiosRepository = municipiosRepository;
            _estadosCivilesRepository = estadosCivilesRepository;

        }



        #region Departamentos


        //INDEX
        public IEnumerable<VW_Departamentos> ListDepartamentos()
        {
            var result = new ServiceResult();
            try
            {
                var list = _departamentosRepository.List();
                return list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_Departamentos>();
            }
        }


        //INSERT
        public ServiceResult InsertDepartamentos(tbDepartamentos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _departamentosRepository.Insert(item);
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


        public ServiceResult UpdateDepartamentos(tbDepartamentos item)
        {
            var result = new ServiceResult();

            try
            {
                var map = _departamentosRepository.Update(item);

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

        public ServiceResult DeleteDepartamentos(int id)
        {
            var result = new ServiceResult();
            try
            {
                var map = _departamentosRepository.Delete(id);
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

        #region Estados Civiles


        //INDEX
        public IEnumerable<VW_EstadosCiviles> ListEstadosCiviles()
        {
            var result = new ServiceResult();
            try
            {
                var list = _estadosCivilesRepository.List();
                return list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_EstadosCiviles>();
            }
        }


        //INSERT
        public ServiceResult InsertEstadosCiviles(tbEstadosCiviles item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _estadosCivilesRepository.Insert(item);
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

     
        public ServiceResult UpdateEstadosCiviles(tbEstadosCiviles item)
        {
            var result = new ServiceResult();

            try
            {
                var map = _estadosCivilesRepository.Update(item);

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

        public ServiceResult DeleteEstadosCiviles(int id)
        {
            var result = new ServiceResult();
            try
            {
                var map = _estadosCivilesRepository.Delete(id);
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

        #region Municipios


        //INDEX
        public IEnumerable<VW_Municipios> ListMunicipios()
        {
            var result = new ServiceResult();
            try
            {
                var list = _municipiosRepository.List();
                return list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_Municipios>();
            }
        }
        public IEnumerable<tbMunicipios> ListarMunicipiosPorDepto(tbMunicipios item)
        {
            try
            {
                var list = _municipiosRepository.ListarMunisDeptos(item);
                return list;
            }
            catch (Exception ex)
            {
                _ = ex.Message;
                return Enumerable.Empty<tbMunicipios>();
            }
        }



        //INSERT
        public ServiceResult InsertMunicipios(tbMunicipios item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _municipiosRepository.Insert(item);
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



        public ServiceResult UpdateMunicipios(tbMunicipios item)
        {
            var result = new ServiceResult();

            try
            {
                var map = _municipiosRepository.Update(item);

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

        public ServiceResult DeleteMunicipios(int id)
        {
            var result = new ServiceResult();
            try
            {
                var map = _municipiosRepository.Delete(id);
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

    }
}
