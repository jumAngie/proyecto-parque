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
    public class MunicipiosRepository : IRepository<tbMunicipios, VW_Municipios>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@muni_ID", id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.DELETE_MUNICIPIOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public VW_Municipios Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@muni_ID", id, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<VW_Municipios>(ScriptsDatabase.FIND_MUNICIPIOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Insert(tbMunicipios item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@muni_ID", item.muni_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@dept_ID", item.dept_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@muni_Nombre", item.muni_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@muni_UsuarioCreador", item.muni_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.INSERT_MUNICIPIOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbMunicipios> ListarMunisDeptos(tbMunicipios tbMunicipios)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);

            var parametros = new DynamicParameters();
            parametros.Add("@dept_ID", tbMunicipios.dept_ID, DbType.Int32, ParameterDirection.Input);
            return db.Query<tbMunicipios>(ScriptsDatabase.FILTRAR_MUNICIPIOS, parametros, commandType: CommandType.StoredProcedure);

        }


        public IEnumerable<VW_Municipios> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            return db.Query<VW_Municipios>(ScriptsDatabase.INDEX_MUNICIPIOS, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbMunicipios item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@muni_ID", item.muni_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@dept_ID", item.dept_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@muni_Nombre", item.muni_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@muni_UsuarioModificador", item.muni_UsuarioModificador, DbType.Int32, ParameterDirection.Input);
            var result = db.QueryFirst<RequestStatus>(ScriptsDatabase.UPDATE_MUNICIPIOS, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


    }
}
