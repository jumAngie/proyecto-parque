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

        public FilaServices(
            HistorialVisitantesAtraccionRepository historialVisitantesAtraccionRepository
        )
        {
            _historialVisitantesAtraccionRepository = historialVisitantesAtraccionRepository;
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
    }
}
