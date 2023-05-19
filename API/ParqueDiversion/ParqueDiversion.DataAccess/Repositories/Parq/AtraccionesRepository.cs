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
    public class AtraccionesRepository : IRepository<tbAtracciones, VW_tbAtracciones>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@atra_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Atracciones_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbAtracciones Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@atra_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbAtracciones>(ScriptsDatabase.UDP_Atracciones_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbAtracciones item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@area_ID", item.area_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_Nombre", item.atra_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_Descripcion", item.atra_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@regi_ID", item.area_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_ReferenciaUbicacion", item.atra_ReferenciaUbicacion, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_LimitePersonas", item.atra_LimitePersonas, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_DuracionRonda", item.atra_DuracionRonda, DbType.Time, ParameterDirection.Input);
            parametros.Add("@atra_Imagen", item.atra_Imagen, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_UsuarioCreador", item.atra_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Atracciones_Insert, parametros, commandType: CommandType.StoredProcedure);

        }

        public IEnumerable<VW_tbAtracciones> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbAtracciones>(ScriptsDatabase.UDP_Atracciones_List, null, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbAtracciones item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@atra_ID", item.atra_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@area_ID", item.area_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_Nombre", item.atra_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_Descripcion", item.atra_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@regi_ID", item.area_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_ReferenciaUbicacion", item.atra_ReferenciaUbicacion, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_LimitePersonas", item.atra_LimitePersonas, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_DuracionRonda", item.atra_DuracionRonda, DbType.Time, ParameterDirection.Input);
            parametros.Add("@atra_Imagen", item.atra_Imagen, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_UsuarioModificador", item.atra_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Atracciones_Update, parametros, commandType: CommandType.StoredProcedure);

        }
    }
}
