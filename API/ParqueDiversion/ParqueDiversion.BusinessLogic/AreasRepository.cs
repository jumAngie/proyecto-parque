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
    public class AreasRepository : IRepository<tbAreas, VW_tbAreas>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@area_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Areas_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbAreas Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@clie_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbAreas>(ScriptsDatabase.UDP_Areas_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbAreas item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@area_Nombre", item.area_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_Descripcion", item.area_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@regi_ID", item.regi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@area_UbicaionReferencia", item.area_UbicaionReferencia, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_Imagen", item.area_Imagen, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_UsuarioCreador", item.area_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Areas_Insert, parametros, commandType: CommandType.StoredProcedure);

        }

        public IEnumerable<VW_tbAreas> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbAreas>(ScriptsDatabase.UDP_Areas_List, null, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbAreas item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@area_ID", item.area_ID, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_Nombre", item.area_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_Descripcion", item.area_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@regi_ID", item.regi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@area_UbicaionReferencia", item.area_UbicaionReferencia, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_Imagen", item.area_Imagen, DbType.String, ParameterDirection.Input);
            parametros.Add("@area_UsuarioModificador", item.area_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Areas_Update, parametros, commandType: CommandType.StoredProcedure);

        }
    }
}
