﻿using Dapper;
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
    public class TicketClientesRepository : IRepository<tbTicketsCliente, VW_tbTicketClientes>
    {
        public RequestStatus Delete(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@ticl_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_TicketClientes_Delete, parametros, commandType: CommandType.StoredProcedure);

        }

        public VW_tbTicketClientes Find(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@ticl_ID", id, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<VW_tbTicketClientes>(ScriptsDatabase.UDP_TicketClientes_Find, parametros, commandType: CommandType.StoredProcedure);

        }

        public RequestStatus Insert(tbTicketsCliente item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tckt_ID", item.tckt_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clie_ID", item.clie_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticl_Cantidad", item.ticl_Cantidad, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticl_FechaCompra", item.ticl_FechaCompra, DbType.DateTime, ParameterDirection.Input);
            parametros.Add("@ticl_FechaUso", item.ticl_FechaUso, DbType.DateTime, ParameterDirection.Input);
            parametros.Add("@ticl_UsuarioCreador", item.ticl_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_TicketClientes_Insert, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbTicketClientes> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbTicketClientes>(ScriptsDatabase.UDP_TicketClientes_List, null, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbTicketsCliente item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticl_ID", item.ticl_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tckt_ID", item.tckt_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clie_ID", item.clie_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticl_Cantidad", item.ticl_Cantidad, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticl_FechaCompra", item.ticl_FechaCompra, DbType.DateTime, ParameterDirection.Input);
            parametros.Add("@ticl_FechaUso", item.ticl_FechaUso, DbType.DateTime, ParameterDirection.Input);
            parametros.Add("@ticl_UsuarioModificador", item.ticl_UsuarioModificador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_TicketClientes_Update, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus FullInsert(VW_tbTicketsClienteForInsert item)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@clie_Nombres", item.clie_Nombres, DbType.String, ParameterDirection.Input);
            parametros.Add("@clie_Apellidos", item.clie_Apellidos, DbType.String, ParameterDirection.Input);
            parametros.Add("@clie_DNI", item.clie_DNI, DbType.String, ParameterDirection.Input);
            parametros.Add("@clie_Telefono", item.clie_Telefono, DbType.String, ParameterDirection.Input);
            parametros.Add("@clie_Sexo", item.clie_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@wasSearched", item.wasSearched, DbType.Int32, ParameterDirection.Input);

            parametros.Add("@tckt_ID", item.tckt_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticl_Cantidad", item.ticl_Cantidad, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@pago_ID", item.pago_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticl_UsuarioCreador", item.ticl_UsuarioCreador, DbType.Int32, ParameterDirection.Input);

            return db.QueryFirst<RequestStatus>(ScriptsDatabase.UDP_TicketsCliente_FullInsert, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<VW_tbTicketClientes> Reporte(int id)
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@clie_ID", id, DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_tbTicketClientes>(ScriptsDatabase.UDP_ReporteByCliente, parametros, commandType: CommandType.StoredProcedure);
        }

    }
}
