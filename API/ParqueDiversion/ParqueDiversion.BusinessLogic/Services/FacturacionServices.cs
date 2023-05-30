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
        public ServiceResult ListadoVenta()
        {
            var result = new ServiceResult();

            try
            {
                var list = _ventasQuioscoRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }        
        
        public ServiceResult ListadoVentaFind(int id)
        {
            var result = new ServiceResult();

            try
            {
                var list = _ventasQuioscoRepository.FindVenta(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
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


        public ServiceResult PagosList()
        {
            var result = new ServiceResult();
            try
            {
                var list = _ventasQuioscoRepository.PagosList();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion


        #region Ventas Quiosco Detalle
        public ServiceResult ListadoVentaDetalle()
        {
            var result = new ServiceResult();
            try
            {
                var list = _ventasQuioscoDetalleRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult DetallesByVenta(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _ventasQuioscoDetalleRepository.DetallesByVenta(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
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

        public ServiceResult DeleteInsumo(tbVentasQuioscoDetalle item)
        {
            var result = new ServiceResult();
            try
            {
                var ans = _ventasQuioscoDetalleRepository.DeleteInsumo(item);
                if (ans.CodeStatus == 200)
                {
                    return result.SetMessage(ans.MessageStatus, ServiceResultType.Success);
                }
                else if(ans.CodeStatus == 409)
                {
                    return result.SetMessage(ans.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(ans.MessageStatus, ServiceResultType.Error);
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
