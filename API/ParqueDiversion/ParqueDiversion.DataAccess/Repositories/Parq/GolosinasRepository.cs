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
    public class GolosinasRepository : IRepository<tbGolosinas, VW_tbGolosinas>
    {
        public RequestStatus Delete(int id)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@golo_ID", id, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Golosinas_Delete, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public VW_tbGolosinas Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbGolosinas item)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            
            parametros.Add("@golo_Nombre", item.golo_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@golo_Img", item.golo_Img, DbType.String, ParameterDirection.Input);
            parametros.Add("@golo_Precio", item.golo_Precio, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@golo_UsuarioCreador", item.golo_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Golosinas_Insert, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_tbGolosinas> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbGolosinas>(ScriptsDatabase.UDP_Golosinas_List, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbGolosinas item)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@golo_ID", item.golo_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@golo_Nombre", item.golo_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@golo_Img", item.golo_Img, DbType.String, ParameterDirection.Input);
            parametros.Add("@golo_Precio", item.golo_Precio, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@golo_UsuarioModificador", item.golo_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Golosinas_Update, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}
