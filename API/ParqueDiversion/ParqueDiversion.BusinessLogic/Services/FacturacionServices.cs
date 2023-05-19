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
    public class FacturacionServices
    {
        private readonly VentasQuioscoRepository _ventasQuioscoRepository;
        private readonly VentasQuioscoDetalleRepository _ventasQuioscoDetalleRepository;

        public FacturacionServices(
                VentasQuioscoRepository ventasQuioscoRepository,
                VentasQuioscoDetalleRepository ventasQuioscoDetalleRepository
            )
        {
            _ventasQuioscoRepository = ventasQuioscoRepository;
            _ventasQuioscoDetalleRepository = ventasQuioscoDetalleRepository;
        }

        #region Ventas Quiosco
        public IEnumerable<VW_tbVentasQuioscoDetalle> ListadoVenta()
        {
            try
            {
                return _ventasQuioscoDetalleRepository.List();
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<VW_tbVentasQuioscoDetalle>();
            }
        }

        public ServiceResult InsertVenta(tbVentasQuiosco item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _ventasQuioscoRepository.Insert(item);
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


        #region Ventas Quiosco Detalle
        public IEnumerable<VW_tbVentasQuioscoDetalle> ListadoVentaDetalle()
        {
            try
            {
                return _ventasQuioscoDetalleRepository.List();
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<VW_tbVentasQuioscoDetalle>();
            }
        }

        public ServiceResult InsertVentaDetalle(tbVentasQuioscoDetalle item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _ventasQuioscoDetalleRepository.Insert(item);
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
