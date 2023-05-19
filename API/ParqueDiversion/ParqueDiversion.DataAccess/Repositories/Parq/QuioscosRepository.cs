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
    public class QuioscosRepository : IRepository<tbQuioscos, VW_tbQuioscos>
    {
        public RequestStatus Delete(int id)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@quio_ID", id, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Quioscos_Delete, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public VW_tbQuioscos Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbQuioscos item)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@area_ID", item.area_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@quio_Nombre", item.quio_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_ID", item.empl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@regi_ID", item.regi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@quio_ReferenciaUbicacion", item.quio_ReferenciaUbicacion, DbType.String, ParameterDirection.Input);
            parametros.Add("@quio_Imagen", item.quio_Imagen, DbType.String, ParameterDirection.Input);
            parametros.Add("@quio_UsuarioCreador", item.quio_UsuarioCreador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Quioscos_Insert, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_tbQuioscos> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbQuioscos>(ScriptsDatabase.UDP_Quioscos_List, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbQuioscos item)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@quio_ID", item.quio_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@area_ID", item.area_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@quio_Nombre", item.quio_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_ID", item.empl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@regi_ID", item.regi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@quio_ReferenciaUbicacion", item.quio_ReferenciaUbicacion, DbType.String, ParameterDirection.Input);
            parametros.Add("@quio_Imagen", item.quio_Imagen, DbType.String, ParameterDirection.Input);
            parametros.Add("@quio_UsuarioModificador", item.quio_UsuarioModificador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Quioscos_Update, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}
