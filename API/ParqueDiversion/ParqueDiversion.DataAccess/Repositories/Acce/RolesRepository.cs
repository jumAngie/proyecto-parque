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
    public class RolesRepository : IRepository<tbRoles, VW_Roles>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@role_ID", id, DbType.String, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.DELETE_ROLES, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }

        public VW_Roles Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbRoles item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<RequestStatus> InsertYId(tbRoles item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@role_Nombre", item.role_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@role_UsuarioCreador", item.role_UsuarioCreador, DbType.Int32, ParameterDirection.Input);
            return db.Query<RequestStatus>(ScriptsDatabase.INSERT_ROLES, parametros, commandType: System.Data.CommandType.StoredProcedure);

        }


        public IEnumerable<VW_Roles> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            return db.Query<VW_Roles>(ScriptsDatabase.INDEX_ROLES, null, commandType: System.Data.CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbRoles item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@role_ID", item.role_ID, DbType.String, ParameterDirection.Input);
            parametros.Add("@role_Nombre", item.role_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@role_UsuarioModificador", item.role_UsuarioModificador, DbType.Int32, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UPDATE_ROLES, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }
    }
}
