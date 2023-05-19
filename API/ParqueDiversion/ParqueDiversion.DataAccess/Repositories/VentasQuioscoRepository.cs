﻿using Dapper;
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
    public class VentasQuioscoRepository : IRepository<tbVentasQuiosco, VW_tbVentasQuiosco>
    {
        public RequestStatus Delete(int id)
        {
            throw new NotImplementedException();
        }

        public VW_tbVentasQuiosco Find(int id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbVentasQuiosco item)
        {
            RequestStatus result = new();

            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@quio_ID", item.quio_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@clie_ID", item.clie_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@pago_ID", item.pago_ID, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@vent_UsuarioCreador", item.vent_UsuarioCreador, DbType.Int32, ParameterDirection.Input);
            
            var answer = db.QueryFirst<string>(ScriptsDatabase.UDP_VentasQuiosco_Insert, parametros, commandType: CommandType.StoredProcedure);
            result.MessageStatus = answer;
            return result;
        }

        public IEnumerable<VW_tbVentasQuiosco> List()
        {
            using var db = new SqlConnection(ParqueDiversionContext.ConnectionString);
            var parametros = new DynamicParameters();
            return db.Query<VW_tbVentasQuiosco>(ScriptsDatabase.UDP_VentasQuiosco_List, parametros, commandType: CommandType.StoredProcedure);
        }

        public RequestStatus Update(tbVentasQuiosco item)
        {
            throw new NotImplementedException();
        }
    }
}
