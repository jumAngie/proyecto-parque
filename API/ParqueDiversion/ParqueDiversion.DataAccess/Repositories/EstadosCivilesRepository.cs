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
    public class EstadosCivilesRepository : IRepository<tbEstadosCiviles, VW_EstadosCiviles>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@civi_ID", id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.DELETE_ESTADOSCIVILES, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public VW_EstadosCiviles Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@civi_ID", id, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<VW_EstadosCiviles>(ScriptsDatabase.FIND_ESTADOSCIVILES, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Insert(tbEstadosCiviles item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@civi_Descripcion", item.civi_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@civi_UsuarioCreador", item.civi_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.INSERT_ESTADOSCIVILES, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public IEnumerable<VW_EstadosCiviles> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            return db.Query<VW_EstadosCiviles>(ScriptsDatabase.INDEX_ESTADOSCIVILES, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbEstadosCiviles item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@civi_ID", item.civi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@civi_Descripcion", item.civi_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@civi_UsuarioModificador", item.civi_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UPDATE_ESTADOSCIVILES, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


    }
}
