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
    public class UsuariosRepository : IRepository<tbUsuarios, VW_Usuarios>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@usua_ID", id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Usuarios_DELETE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public VW_Usuarios Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@user_Id", id, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<VW_Usuarios>(ScriptsDatabase.UDP_Usuarios_FIND, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Insert(tbUsuarios item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@usua_Usuario", item.usua_Usuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Admin", item.usua_Admin, DbType.Boolean, ParameterDirection.Input);
            parametros.Add("@empl_ID", item.empl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_ID", item.role_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@usua_Img", item.usua_Img, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_UsuarioCreador", item.usua_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Usuario_INSERT, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_Usuarios> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            return db.Query<VW_Usuarios>(ScriptsDatabase.UDP_Usuario_INDEX, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbUsuarios item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@usua_ID", item.usua_ID, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_ID", item.empl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_ID", item.role_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@usua_Admin", item.usua_Admin, DbType.Boolean, ParameterDirection.Input);
            parametros.Add("@usua_UsuarioModificador", item.usua_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Usuarios_UPDATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Pass(tbUsuarios item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@usua_ID", item.usua_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Usuarios_PASS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public VW_Usuarios Login(string username, string password)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_Usuario", username, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Clave", password, DbType.String, ParameterDirection.Input);

            var result = db.QueryFirst<VW_Usuarios>(ScriptsDatabase.UDP_Usuarios_LOGIN, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_Pantallas> Menu(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@usua_ID", id, DbType.String, ParameterDirection.Input);

            var result = db.Query<VW_Pantallas>(ScriptsDatabase.UDP_Usuarios_MENU, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
    }
}
