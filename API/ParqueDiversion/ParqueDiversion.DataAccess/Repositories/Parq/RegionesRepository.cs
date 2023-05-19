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
    public class RegionesRepository : IRepository<tbRegiones, VW_tbRegiones>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@regi_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Regiones_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbRegiones Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@regi_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbRegiones>(ScriptsDatabase.UDP_Regiones_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbRegiones item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@regi_Nombre",         item.regi_Nombre,         DbType.String, ParameterDirection.Input);
            parametros.Add("@regi_UsuarioCreador", item.regi_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Regiones_Insert, parametros, commandType: CommandType.StoredProcedure);

        }

        public IEnumerable<VW_tbRegiones> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbRegiones>(ScriptsDatabase.UDP_Regiones_List, null, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbRegiones item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@regi_ID ",                 item.regi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@regi_Nombre",              item.regi_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@regi_UsuarioModificador",  item.regi_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Regiones_Update, parametros, commandType: CommandType.StoredProcedure);

        }
    }
}
