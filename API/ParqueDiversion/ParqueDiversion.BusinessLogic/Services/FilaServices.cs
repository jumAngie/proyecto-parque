using Paqueteria.BusinessLogic;
using ParqueDiversion.DataAccess.Repositories.Fila;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.BusinessLogic.Services
{
    public class FilaServices
    {
        private readonly HistorialVisitantesAtraccionRepository _historialVisitantesAtraccionRepository;
        private readonly FilasRepository _filasRepository;


        public FilaServices(
            HistorialVisitantesAtraccionRepository historialVisitantesAtraccionRepository,
            FilasRepository filasRepository
        )
        {
            _historialVisitantesAtraccionRepository = historialVisitantesAtraccionRepository;
            _filasRepository = filasRepository;
        }

        #region Historial Visitantes Atracción
        public ServiceResult GetChartData(string fechaInicial, string fechaFinal)
        {
            var result = new ServiceResult();
            try
            {
                var list = _historialVisitantesAtraccionRepository.GraphicData(fechaInicial, fechaFinal);
                return result.Ok(list);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Filas Posicion

        //INDEX
        public IEnumerable<VW_tbFilasPosiciones> ListPosiciones(int tifi_ID, int atra_ID)
        {
            try
            {   
                var list = _filasRepository.List(tifi_ID,atra_ID);
                return list;
            }
            catch (Exception e)
            {
                _ = e.Message;
                return Enumerable.Empty<VW_tbFilasPosiciones>();
            }
        }


        //INSERT
        public ServiceResult InsertPosiciones(int atra_ID, string ticl_ID)
        {
            var result = new ServiceResult();
            try
            {
                var map = _filasRepository.Insert(atra_ID,ticl_ID);
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

        //Delete
        public ServiceResult DeleteCompleto(int atra_ID, int fiat_ID)
        {
            var result = new ServiceResult();
            try
            {
                var map = _filasRepository.DeleteCompleto(atra_ID, fiat_ID);
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

        //Delete
        public ServiceResult Delete(int fipo_ID)
        {
            var result = new ServiceResult();
            try
            {
                var map = _filasRepository.Delete(fipo_ID);
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
