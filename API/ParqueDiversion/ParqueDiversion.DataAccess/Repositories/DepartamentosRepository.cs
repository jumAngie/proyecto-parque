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
    public class DepartamentosRepository : IRepository<tbDepartamentos, VW_Departamentos>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@dept_ID", id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.DELETE_DEPARTAMENTOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public VW_Departamentos Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@dept_ID", id, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<VW_Departamentos>(ScriptsDatabase.FIND_DEPARTAMENTOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Insert(tbDepartamentos item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@dept_ID", item.dept_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@dept_Codigo", item.dept_Codigo, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_Nombre", item.dept_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_UsuarioCreador", item.dept_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.INSERT_DEPARTAMENTOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public IEnumerable<VW_Departamentos> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            return db.Query<VW_Departamentos>(ScriptsDatabase.INDEX_DEPARTAMENTOS, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbDepartamentos item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@dept_ID", item.dept_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@dept_Codigo", item.dept_Codigo, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_Nombre", item.dept_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_UsuarioModificador", item.dept_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UPDATE_DEPARTAMENTOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


    }
}
