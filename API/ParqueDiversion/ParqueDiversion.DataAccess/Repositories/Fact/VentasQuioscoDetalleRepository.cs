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

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@vent_ID", item.vent_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@insu_ID", item.insu_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@deta_Cantidad", item.deta_Cantidad, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@deta_UsuarioCreador", item.deta_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_VentasQuioscoDetalle_Insert, parametros, commandType: CommandType.StoredProcedure);            
            return result;
        }

        public IEnumerable<VW_tbVentasQuioscoDetalle> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbVentasQuioscoDetalle>(ScriptsDatabase.UDP_VentasQuioscoDetalle_List, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbVentasQuioscoDetalle> DetallesByVenta(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@vent_ID", id , DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_tbVentasQuioscoDetalle>(ScriptsDatabase.UDP_VentasQuioscoDetalle_DetalleByVenta, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbVentasQuioscoDetalle item)
        {
            throw new NotImplementedException();
        }
    }
}
