using Dapper;
using Microsoft.Data.SqlClient;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories
{
    public class VentasQuioscoDetalleRepository : IRepository<tbVentasQuioscoDetalle, VW_tbVentasQuioscoDetalle>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbVentasQuioscoDetalle Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbVentasQuioscoDetalle item)
        {
            RequestStatus result = new();

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@vent_ID", item.vent_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@golo_ID", item.golo_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@deta_Cantidad", item.deta_Cantidad, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@deta_UsuarioCreador", item.deta_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var answer = db.QueryFirst<string>(ScriptsDatabase.UDP_VentasQuioscoDetalle_Insert, parametros, commandType: CommandType.StoredProcedure);
            result.MessageStatus = answer;
            return result;
        }

        public IEnumerable<VW_tbVentasQuioscoDetalle> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbVentasQuioscoDetalle>(ScriptsDatabase.UDP_VentasQuioscoDetalle_List, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbVentasQuioscoDetalle item)
        {
            throw new NotImplementedException();
        }
    }
}
