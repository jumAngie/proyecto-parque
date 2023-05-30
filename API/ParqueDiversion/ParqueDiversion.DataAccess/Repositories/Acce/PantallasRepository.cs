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
    public class PantallasRepository : IRepository<tbPantallas, VW_Pantallas>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_Pantallas Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbPantallas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<VW_Pantallas> PantallasPorRol_Checked(int role_ID)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@role_ID", role_ID, DbType.String, ParameterDirection.Input);
            return db.Query<VW_Pantallas>(ScriptsDatabase.UDP_tbPantallasPorRol_Checked, parametros, commandType: System.Data.CommandType.StoredProcedure);
        }

        public IEnumerable<VW_Pantallas> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            return db.Query<VW_Pantallas>(ScriptsDatabase.INDEX_PANTALLAS, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus InsertP(int role_Id, int pant_Id, int pantrol_UserCrea)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@role_ID", role_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@pant_ID", pant_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ropa_UsuarioCreador", pantrol_UserCrea, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst(ScriptsDatabase.INSERT_PANTALLASROL, parametros, commandType: CommandType.StoredProcedure);
            var codeStatus = Convert.ToInt32(result.codeStatus);
            var messageStatus = result.messageStatus.ToString();

            return new RequestStatus
            {
                CodeStatus = codeStatus,
                MessageStatus = messageStatus
            };
        }


        public RequestStatus DeleteP(int role_ID, int pant_ID, int ropa_UsuarioModificador)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@role_ID", role_ID, DbType.String, ParameterDirection.Input);
            parametros.Add("@pant_ID", pant_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ropa_UsuarioModificador", ropa_UsuarioModificador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst(ScriptsDatabase.DELETE_PANTALLASROL, parametros, commandType: CommandType.StoredProcedure);
            var codeStatus = Convert.ToInt32(result.codeStatus);
            var messageStatus = result.messageStatus.ToString();

            return new RequestStatus
            {
                CodeStatus = codeStatus,
                MessageStatus = messageStatus
            };
        }

        public RequestStatus Update(int role_ID)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@role_ID", role_ID, DbType.String, ParameterDirection.Input);
            
            var result = db.QueryFirst(ScriptsDatabase.DELETE_PANTALLASROLES, parametros, commandType: CommandType.StoredProcedure);
            var codeStatus = Convert.ToInt32(result.codeStatus);
            var messageStatus = result.messageStatus.ToString();

            return new RequestStatus
            {
                CodeStatus = codeStatus,
                MessageStatus = messageStatus
            };
        }

        public RequestStatus Update(tbPantallas item)
        {
            throw new NotImplementedException();
        }
    }
}
