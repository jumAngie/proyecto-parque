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
    public class RatingsRepository : IRepository<tbRatings, tbRatings>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public tbRatings Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbRatings item)
        {
            
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@atra_ID", item.atra_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clie_ID", item.clie_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@rati_Estrellas", item.rati_Estrellas, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@rati_Comentario", item.rati_Comentario, DbType.String, ParameterDirection.Input);
            parametros.Add("@rati_UsuarioCreador", item.rati_UsuarioCreador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Ratings_Insert, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbRatings> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbRatings item)
        {
            throw new NotImplementedException();
        }
    }
}
