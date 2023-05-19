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
    public class TicketRepository : IRepository<tbTickets, VW_tbTickets>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@tckt_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Ticket_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbTickets Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@tckt_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbTickets>(ScriptsDatabase.UDP_Ticket_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbTickets item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tckt_Nombre", item.tckt_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@tckt_Precio", item.tckt_Precio, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tckt_UsuarioCreador", item.tckt_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Ticket_Insert, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbTickets> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbTickets>(ScriptsDatabase.UDP_Ticket_List, null, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbTickets item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tckt_ID", item.tckt_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tckt_Nombre", item.tckt_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@tckt_Precio", item.tckt_Precio, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tckt_UsuarioModificador", item.tckt_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_Ticket_Update, parametros, commandType: CommandType.StoredProcedure);
        }
    }
}
