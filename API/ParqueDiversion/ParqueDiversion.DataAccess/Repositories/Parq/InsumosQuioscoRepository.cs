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
    public class InsumosQuioscoRepository : IRepository<tbInsumosQuiosco, VW_tbInsumosQuiosco>
    {
        public RequestStatus Delete(int id)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@insu_ID", id, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_InsumosQuiosco_Delete, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public VW_tbInsumosQuiosco Find(int id)
        {
            throw new NotImplementedException();
        }


        public RequestStatus Insert(tbInsumosQuiosco item)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@quio_ID", item.quio_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@golo_ID", item.golo_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@insu_Stock", item.insu_Stock, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@insu_UsuarioCreador", item.insu_UsuarioCreador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_InsumosQuiosco_Insert, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_tbInsumosQuiosco> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbInsumosQuiosco>(ScriptsDatabase.UDP_InsumosQuiosco_List, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbInsumosQuiosco> InsumosByQuiosco(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@quio_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.Query<VW_tbInsumosQuiosco>(ScriptsDatabase.UDP_InsumosQuiosco_InsumosByQuiosco, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbInsumosQuiosco item)
        {
            throw new NotImplementedException();
        }
    }
}
