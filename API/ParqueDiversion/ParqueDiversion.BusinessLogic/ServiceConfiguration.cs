using Microsoft.Extensions.DependencyInjection;
using ParqueDiversion.BusinessLogic.Services;
using ParqueDiversion.DataAccess;
using ParqueDiversion.DataAccess.Repositories;
using ParqueDiversion.DataAccess.Repositories.Parq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.BusinessLogic
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connectionString)
        {
            #region Parque
            services.AddScoped<EmpleadosRepository>();
            services.AddScoped<QuioscosRepository>();
            services.AddScoped<GolosinasRepository>();
            services.AddScoped<InsumosQuioscoRepository>();
            services.AddScoped<RatingsRepository>();
            services.AddScoped<CargoRepository>();
            services.AddScoped<RegionesRepository>();
            services.AddScoped<ClientesRepository>();
            services.AddScoped<ClientesRegistradosRepository>();
            services.AddScoped<TicketRepository>();
            services.AddScoped<TicketClientesRepository>();
            services.AddScoped<AtraccionesRepository>();
            services.AddScoped<AreasRepository>();

            ParqueDiversionContext.BuildConnectionString(connectionString);
            #endregion

            #region Facturación
            services.AddScoped<VentasQuioscoRepository>();
            services.AddScoped<VentasQuioscoDetalleRepository>();
            #endregion


        }
        
        public static void BusinessLogic(this IServiceCollection services)
        {
            services.AddScoped<AccessServices>();
            services.AddScoped<GeneralesServices>();
            services.AddScoped<ParqueServices>();
            services.AddScoped<FacturacionServices>();
            services.AddScoped<FilaServices>();

        }
    }
}
