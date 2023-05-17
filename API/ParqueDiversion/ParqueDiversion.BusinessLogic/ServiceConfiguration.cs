using Microsoft.Extensions.DependencyInjection;
using ParqueDiversion.BusinessLogic.Services;
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

        }

        public static void BusinessLogic(this IServiceCollection services)
        {
            services.AddScoped<AccessServices>();
            services.AddScoped<GeneralesServices>();
            services.AddScoped<ParqueServices>();
            services.AddScoped<FacturacionServices>();

        }
    }
}
