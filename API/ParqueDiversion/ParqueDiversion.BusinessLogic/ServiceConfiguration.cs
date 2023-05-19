using Microsoft.Extensions.DependencyInjection;
using ParqueDiversion.BusinessLogic.Services;
using ParqueDiversion.DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParqueDiversion.BusinessLogic
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connection)
        {
            #region Parque
            services.AddScoped<EmpleadosRepository>();
            services.AddScoped<QuioscosRepository>();
            services.AddScoped<GolosinasRepository>();
            services.AddScoped<InsumosQuioscoRepository>();
            services.AddScoped<RatingsRepository>();

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
