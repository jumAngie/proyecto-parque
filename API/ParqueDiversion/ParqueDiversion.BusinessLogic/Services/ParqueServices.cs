﻿using Paqueteria.BusinessLogic;
using ParqueDiversion.DataAccess.Repositories;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.BusinessLogic.Services
{
    public class ParqueServices
    {
        private readonly EmpleadosRepository _empleadosRepository;
        private readonly QuioscosRepository _quioscosRepository;
        private readonly GolosinasRepository _golosinasRepository;
        private readonly InsumosQuioscoRepository _insumosQuioscoRepository;
        private readonly RatingsRepository _ratingsRepository;
        public ParqueServices(
                EmpleadosRepository empleadosRepository,
                QuioscosRepository quioscosRepository,
                GolosinasRepository golosinasRepository,
                InsumosQuioscoRepository insumosQuioscoRepository,
                RatingsRepository ratingsRepository
            )
        {
            _empleadosRepository = empleadosRepository;
            _quioscosRepository = quioscosRepository;
            _golosinasRepository = golosinasRepository;
            _insumosQuioscoRepository = insumosQuioscoRepository;
            _ratingsRepository = ratingsRepository;
        }

        #region Empleados
        public IEnumerable<VW_tbEmpleados> ListadoEmpleados()
        {
            try
            {
                return _empleadosRepository.List();
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<VW_tbEmpleados>();
            }
        }

        public ServiceResult InsertEmpleado(tbEmpleados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _empleadosRepository.Insert(item);
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

        public ServiceResult UpdateEmpleados(tbEmpleados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _empleadosRepository.Update(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);
                }else if (map.CodeStatus == 409)
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

        public ServiceResult DeleteEmpleado(tbEmpleados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _empleadosRepository.Delete(item.empl_ID);
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

        #region Quioscos
        public IEnumerable<VW_tbQuioscos> ListadoQuiosco()
        {
            try
            {
                return _quioscosRepository.List();
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<VW_tbQuioscos>();
            }
        }

        public ServiceResult InsertQuiosco(tbQuioscos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _quioscosRepository.Insert(item);
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

        public ServiceResult UpdateQuiosco(tbQuioscos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _quioscosRepository.Update(item);
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

        public ServiceResult DeleteQuiosco(tbQuioscos item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _quioscosRepository.Delete(item.quio_ID);
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

        #region Golosinas
        public IEnumerable<VW_tbGolosinas> ListadoGolosina()
        {
            try
            {
                return _golosinasRepository.List();
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<VW_tbGolosinas>();
            }
        }

        public ServiceResult InsertGolosina(tbGolosinas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _golosinasRepository.Insert(item);
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

        public ServiceResult UpdateGolosina(tbGolosinas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _golosinasRepository.Update(item);
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

        public ServiceResult DeleteGolosina(tbGolosinas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _golosinasRepository.Delete(item.golo_ID);
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

        #region InsumosQuiosco
        public IEnumerable<VW_tbInsumosQuiosco> ListadoInsumo()
        {
            try
            {
                return _insumosQuioscoRepository.List();
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<VW_tbInsumosQuiosco>();
            }
        }

        public ServiceResult InsertInsumo(tbInsumosQuiosco item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _insumosQuioscoRepository.Insert(item);
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


        public ServiceResult DeleteInsumo(tbInsumosQuiosco item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _insumosQuioscoRepository.Delete(item.insu_ID);
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

        #region Ratings
        public ServiceResult InsertRating(tbRatings item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _ratingsRepository.Insert(item);
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
