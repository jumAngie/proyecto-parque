using Dapper;
using Microsoft.Data.SqlClient;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories.Fila
{
    public class HistorialVisitantesAtraccionRepository : IRepository<tbHistorialVisitantesAtraccion, VW_tbHistorialVisitantesAtraccion>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbHistorialVisitantesAtraccion Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbHistorialVisitantesAtraccion item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbHistorialVisitantesAtraccion> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbHistorialVisitantesAtraccion item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbHistorialVisitantesAtraccion> GraphicData(tbHistorialVisitantesAtraccion item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@hiat_FechaFiltro", item.hiat_FechaFiltro, DbType.Date, ParameterDirection.Input);

            return db.Query<VW_tbHistorialVisitantesAtraccion>(ScriptsDatabase.UDP_GetChartData, parametros, commandType: CommandType.StoredProcedure);
        }
    }
}
