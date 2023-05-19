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
    public class EmpleadosRepository : IRepository<tbEmpleados, VW_tbEmpleados>
    {
        public RequestStatus Delete(int id)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@empl_ID", id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Empleados_Delete, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }

        public VW_tbEmpleados Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbEmpleados item)
        {

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@empl_PrimerNombre", item.empl_PrimerNombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_SegundoNombre", item.empl_SegundoNombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_PrimerApellido", item.empl_PrimerApellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_SegundoApellido", item.empl_SegundoApellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_DNI", item.empl_DNI, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Email", item.empl_Email, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Telefono", item.empl_Telefono, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Sexo", item.empl_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@civi_ID", item.civi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@carg_ID", item.carg_ID, DbType.Int32, ParameterDirection.Input);            
            parametros.Add("@empl_UsuarioCreador", item.empl_UsuarioCreador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Empleados_Insert, parametros, commandType: CommandType.StoredProcedure);
            return result;
        }


        public IEnumerable<VW_tbEmpleados> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbEmpleados>(ScriptsDatabase.UDP_Empleados_List, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Update(tbEmpleados item)
        {


            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@empl_ID", item.empl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@empl_PrimerNombre", item.empl_PrimerNombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_SegundoNombre", item.empl_SegundoNombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_PrimerApellido", item.empl_PrimerApellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_SegundoApellido", item.empl_SegundoApellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_DNI", item.empl_DNI, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Email", item.empl_Email, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Telefono", item.empl_Telefono, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Sexo", item.empl_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@civi_ID", item.civi_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@carg_ID", item.carg_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@empl_UsuarioModificador", item.empl_UsuarioModificador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Empleados_Update, parametros, commandType: CommandType.StoredProcedure);

            return result;
        }
    }
}
