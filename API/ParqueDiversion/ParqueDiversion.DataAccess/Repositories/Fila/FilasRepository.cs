using Dapper;
using Microsoft.Data.SqlClient;
using ParqueDiversion.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.DataAccess.Repositories.Fila
{
    public class FilasRepository : IRepository<tbFilasPosiciones, VW_tbFilasPosiciones>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@fipo_ID", id, DbType.Int32, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_FilasPosiciones_DELETE, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus DeleteCompleto(int atra_ID, int fiat_ID)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@fiat_ID", fiat_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_ID", atra_ID, DbType.Int32, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_FilasPosiciones_DELETE_COMPLETO, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus DeleteTempo(int temp_ID)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@temp_ID", temp_ID, DbType.Int32, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Temporizadores_DELETE, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus DeleteTempoCompleto()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
         
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Temporizadores_DELETE_COMPLETO, null, commandType: CommandType.StoredProcedure);
        }

        public VW_tbFilasPosiciones Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbFilasPosiciones item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(string ticl_ID, string atra_ID, string temp_Expiracion)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticl_ID", ticl_ID, DbType.String, ParameterDirection.Input);
            parametros.Add("@atra_ID", atra_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@temp_Expiracion", temp_Expiracion, DbType.String, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Temporizadores_INSERT, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Insert(int atra_ID, string ticl_ID)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticl_ID", ticl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_ID", atra_ID, DbType.String, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_FilasPosiciones_INSERT, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Extender(int temp_ID, string temp_Expiracion)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@temp_ID", temp_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@temp_Expiracion", temp_Expiracion, DbType.String, ParameterDirection.Input);
            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Temporizadores_EXTENDER, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbFilasPosiciones> List()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<WV_tbTemporizadores> List(int listado)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@listado", listado, DbType.Int32, ParameterDirection.Input);
            return db.Query<WV_tbTemporizadores>(ScriptsDatabase.UDP_Temporizadores_SELECT, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbFilasPosiciones> List(int tifi_ID, int atra_ID)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tifi_ID", tifi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@atra_ID", atra_ID, DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_tbFilasPosiciones>(ScriptsDatabase.UDP_FilasPosiciones_SELECT, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbFilasPosiciones item)
        {
            throw new NotImplementedException();
        }
    }
}
