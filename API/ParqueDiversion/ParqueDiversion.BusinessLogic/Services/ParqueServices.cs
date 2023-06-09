﻿using Paqueteria.BusinessLogic;
using ParqueDiversion.DataAccess;
using ParqueDiversion.DataAccess.Repositories;
using ParqueDiversion.DataAccess.Repositories.Parq;
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
        private readonly AreasRepository _areasRepository;
        private readonly CargoRepository _cargoRepository;
        private readonly RegionesRepository _regionesRepository;
        private readonly ClientesRepository _clientesRepository;
        private readonly ClientesRegistradosRepository _clientesRegistradosRepository;
        private readonly TicketRepository _ticketRepository;
        private readonly TicketClientesRepository _ticketClientesRepository;
        private readonly AtraccionesRepository _atraccionesRepository;

        public ParqueServices(
                ClientesRegistradosRepository clientesRegistradosRepository,
                EmpleadosRepository empleadosRepository,
                QuioscosRepository quioscosRepository,
                GolosinasRepository golosinasRepository,
                InsumosQuioscoRepository insumosQuioscoRepository,
                RatingsRepository ratingsRepository,
                AreasRepository areasRepository,
                CargoRepository cargoRepository,
                RegionesRepository regionesRepository,
                ClientesRepository clientesRepository,
                TicketRepository ticketRepository,
                TicketClientesRepository ticketClientesRepository,
                AtraccionesRepository atraccionesRepository
            )
        {
            _regionesRepository = regionesRepository;
            _cargoRepository = cargoRepository;
            _empleadosRepository = empleadosRepository;
            _quioscosRepository = quioscosRepository;
            _golosinasRepository = golosinasRepository;
            _insumosQuioscoRepository = insumosQuioscoRepository;
            _ratingsRepository = ratingsRepository;
            _areasRepository = areasRepository;
            _clientesRepository = clientesRepository;
            _clientesRegistradosRepository = clientesRegistradosRepository;
            _ticketClientesRepository = ticketClientesRepository;
            _ticketRepository = ticketRepository;
            _atraccionesRepository = atraccionesRepository;
        }

        #region Cargo

        public IEnumerable<VW_tbCargos> CargoList()
        {
            try
            {
                return _cargoRepository.List();
            }
            catch (Exception)
            {

                return Enumerable.Empty<VW_tbCargos>();
            }
        }

        public ServiceResult InsertarCargos(tbCargos item)
        {
            var result = new ServiceResult();

            var map = _cargoRepository.Insert(item);
            return result.Ok(map);
        }

        public VW_tbCargos FindCargo(int id)
        {
            try
            {
                return _cargoRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
            }
        }


        public RequestStatus BorrarCargo(int id)
        {
            try
            {
                return _cargoRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }



        public RequestStatus UpdateCargo(tbCargos tabla)
        {
            try
            {
                return _cargoRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region Regiones
        public ServiceResult RegionList()
        {

            var result = new ServiceResult();

            try
            {

                var list = _regionesRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }

        public ServiceResult InsertarRegiones(tbRegiones item)
        {
            var result = new ServiceResult();

            var map = _regionesRepository.Insert(item);
            return result.Ok(map);
        }

        public VW_tbRegiones FindRegiones(int id)
        {
            try
            {
                return _regionesRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
            }
        }


        public RequestStatus BorrarRegion(int id)
        {
            try
            {
                return _regionesRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }



        public RequestStatus UpdateRegiones(tbRegiones tabla)
        {
            try
            {
                return _regionesRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region Clientes

        public ServiceResult ClientesList()
        {

            var result = new ServiceResult();

            try
            {

                var list = _clientesRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }

        public ServiceResult InsertarClientes(tbClientes item)
        {
            var result = new ServiceResult();

            var map = _clientesRepository.Insert(item);
            return result.Ok(map);
        }

        public ServiceResult FindClientes(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _clientesRepository.Find(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult SearchClienteByDNI(string id)
        {
            var result = new ServiceResult();
            try
            {

                var list = _clientesRepository.SearchByDNI(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


        public RequestStatus BorrarClientes(int id)
        {
            try
            {
                return _clientesRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }



        public RequestStatus UpdateClientes(tbClientes tabla)
        {
            try
            {
                return _clientesRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region Clientes Registrados
        public ServiceResult ClientesRegistradosList()
        {
            var result = new ServiceResult();
            try
            {

                var list = _clientesRegistradosRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }
        public ServiceResult InsertarClientesRegistrados(tbClientesRegistrados item)
        {
            var result = new ServiceResult();

            var map = _clientesRegistradosRepository.Insert(item);
            return result.Ok(map);
        }
        public VW_tbClientesRegistrados FindClientesRegistrados(int id)
        {
            try
            {
                return _clientesRegistradosRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus BorrarClientesRegistrados(int id)
        {
            try
            {
                return _clientesRegistradosRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus UpdateClientesRegistrados(tbClientesRegistrados tabla)
        {
            try
            {
                return _clientesRegistradosRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region Areas
        public ServiceResult AreasList()
        {

            var result = new ServiceResult();

            try
            {

                var list = _areasRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }
        public ServiceResult InsertarAreas(tbAreas item)
        {
            var result = new ServiceResult();

            var map = _areasRepository.Insert(item);
            return result.Ok(map);
        }
        public VW_tbAreas FindAreas(int id)
        {
            try
            {
                return _areasRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus BorrarAreas(int id)
        {
            try
            {
                return _areasRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus UpdateAreas(tbAreas tabla)
        {
            try
            {
                return _areasRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region Ticket
        public ServiceResult TicketList()
        {

            var result = new ServiceResult();

            try
            {

                var list = _ticketRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }
        public ServiceResult InsertarTicket(tbTickets item)
        {
            var result = new ServiceResult();

            var map = _ticketRepository.Insert(item);
            return result.Ok(map);
        }
        public VW_tbTickets FindTicket(int id)
        {
            try
            {
                return _ticketRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus BorrarTicket(int id)
        {
            try
            {
                return _ticketRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus UpdateTicket(tbTickets tabla)
        {
            try
            {
                return _ticketRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }
        #endregion

        #region Ticket Clientes
        public ServiceResult TicketClientesList()
        {

            var result = new ServiceResult();

            try
            {

                var list = _ticketClientesRepository.List();
                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }
        public ServiceResult InsertarTicketClientes(tbTicketsCliente item)
        {
            var result = new ServiceResult();

            var map = _ticketClientesRepository.Insert(item);
            return result.Ok(map);
        }
        public VW_tbTicketClientes FindTicketClientes(int id)
        {
            try
            {
                return _ticketClientesRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public ServiceResult FullTicketInsert(VW_tbTicketsClienteForInsert item)
        {
            var result = new ServiceResult();
            try
            {
                var ans = _ticketClientesRepository.FullInsert(item);
                if (ans.CodeStatus == 200)
                {
                    return result.SetMessage(ans.MessageStatus, ServiceResultType.Success);
                } else if (ans.CodeStatus == 409)
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
                return result.SetMessage(ex.Message, ServiceResultType.Error);
            }
        }

        public RequestStatus BorrarTicketClientes(int id)
        {
            try
            {
                return _ticketClientesRepository.Delete(id);
            }
            catch (Exception)
            {
                return null;
            }
        }
        public RequestStatus UpdateTicketClientes(tbTicketsCliente tabla)
        {
            try
            {
                return _ticketClientesRepository.Update(tabla);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public ServiceResult Reporte(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _ticketClientesRepository.Reporte(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Atracciones
        public ServiceResult AtraccionesList()
        {
            var result = new ServiceResult();

            try
            {
                var list = _atraccionesRepository.List();

                return result.Ok(list);
            }
            catch (Exception e)
            {

                return result.Error(e.Message);
            }
        }
        public ServiceResult InsertarAtracciones(tbAtracciones item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _atraccionesRepository.Insert(item);
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
                return result.SetMessage(ex.Message, ServiceResultType.Error);
            }

        }
        public ServiceResult FindAtracciones(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _atraccionesRepository.FindAtraccion(id);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }

        public ServiceResult FindAtraccionesPorArea(int AreaiD)
        {
            var result = new ServiceResult();
            try
            {
                var list = _atraccionesRepository.FindAtraccionPorIdArea(AreaiD);
                return result.Ok(list);
            }
            catch (Exception e)
            {
                return result.Error(e.Message);
            }
        }
        public ServiceResult BorrarAtracciones(int id)
        {
            var result = new ServiceResult();
            try
            {
                var map = _atraccionesRepository.Delete(id);
                if(map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);
                }
                else if(map.CodeStatus == 409)
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
                return result.SetMessage(ex.Message, ServiceResultType.Error);
            }
        }
        public ServiceResult UpdateAtracciones(tbAtracciones item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _atraccionesRepository.Update(item);
                if (map.CodeStatus ==  200)
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
                return result.SetMessage(ex.Message, ServiceResultType.Error);
            }
        }
        #endregion

        #region Empleados
        public ServiceResult ListadoEmpleados()
        {
            var result = new ServiceResult();
            try
            {
                var list = _empleadosRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public VW_tbEmpleados FindEmpleado(int id)
        {
            try
            {
                return _empleadosRepository.Find(id);
            }
            catch (Exception)
            {
                return null;
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
        public ServiceResult DeleteEmpleado(int id)
        {
            var result = new ServiceResult();
            try
            {
                var map = _empleadosRepository.Delete(id);
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
        public ServiceResult ListadoQuiosco()
        {
            var result = new ServiceResult();
            try
            {   var list =_quioscosRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.SetMessage(ex.Message, ServiceResultType.Error);
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

        public ServiceResult FindQuiosco (int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _quioscosRepository.FindQuiosco(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.SetMessage(ex.Message, ServiceResultType.Error);
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

        public ServiceResult DeleteQuiosco(int item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _quioscosRepository.Delete(item);
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
        public ServiceResult ListadoGolosina()
        {
            var result = new ServiceResult();
            try
            {
                var list = _golosinasRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
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
        public ServiceResult ListadoInsumo()
        {
            var result = new ServiceResult();
            try
            {
                var list = _insumosQuioscoRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.SetMessage(ex.Message, ServiceResultType.Error);
            }
        }

        public ServiceResult InsumosByQuiosco(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _insumosQuioscoRepository.InsumosByQuiosco(id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.SetMessage(ex.Message, ServiceResultType.Error);
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
