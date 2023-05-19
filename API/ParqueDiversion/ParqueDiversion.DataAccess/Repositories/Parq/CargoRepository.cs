using Dapper;
using Microsoft.Data.SqlClient;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories.Parq
{
    public class CargoRepository : IRepository<tbCargos, VW_tbCargos>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@carg_Id", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Cargos_Delete, parametros, commandType: CommandType.StoredProcedure);

    }

        public VW_tbCargos Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@carg_Id", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbCargos>(ScriptsDatabase.UDP_Cargo_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbCargos item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@carg_Nombre",          item.carg_Nombre,         DbType.String, ParameterDirection.Input);
            parametros.Add("@carg_UsuarioCreador",  item.carg_UsuarioCreador, DbType.Int32,  ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Cargo_Insert, parametros, commandType: CommandType.StoredProcedure);

        }

        public IEnumerable<VW_tbCargos> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbCargos>(ScriptsDatabase.UDP_Cargo_List, null, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbCargos item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@carg_ID ", item.carg_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@carg_Nombre ", item.carg_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@carg_UsuarioModificador", item.carg_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Cargo_Update, parametros, commandType: CommandType.StoredProcedure);

        }
    }
}
