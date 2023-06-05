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
    public class ClientesRegistradosRepository : IRepository<tbClientesRegistrados, VW_tbClientesRegistrados>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@clre_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_ClientesRegistrados_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbClientesRegistrados Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@clre_Id", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbClientesRegistrados>(ScriptsDatabase.UDP_ClientesRegistrados_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbClientesRegistrados item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@clie_Nombres", item.clie_Nombres, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clie_Apellidos", item.clie_Apellidos, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clre_Usuario", item.clre_Usuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@clre_Email", item.clre_Email, DbType.String, ParameterDirection.Input);
            parametros.Add("@clre_Clave", item.clre_Clave, DbType.String, ParameterDirection.Input);
            parametros.Add("@clre_UsuarioCreador", item.clre_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_ClientesRegistrados_Insert, parametros, commandType: CommandType.StoredProcedure);

        }

        public IEnumerable<VW_tbClientesRegistrados> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbClientesRegistrados>(ScriptsDatabase.UDP_ClientesRegistrados_List, null, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbClientesRegistrados item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@clre_ID", item.clre_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clie_Apellidos", item.clie_Apellidos, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clre_Usuario", item.clre_Usuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@clre_Usuario", item.clre_Usuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@clre_Email", item.clre_Email, DbType.String, ParameterDirection.Input);
            parametros.Add("@clre_UsuarioModificador", item.clre_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_ClientesRegistrados_Update, parametros, commandType: CommandType.StoredProcedure);

        }
    }
}
