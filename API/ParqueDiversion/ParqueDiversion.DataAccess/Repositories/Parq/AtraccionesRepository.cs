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
    class AtraccionesRepository : IRepository<tbAtracciones, VW_tbAtracciones>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Atracciones_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbAtracciones Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAtracciones item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_tbAtracciones> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAtracciones item)
        {
            throw new NotImplementedException();
        }
    }
}
