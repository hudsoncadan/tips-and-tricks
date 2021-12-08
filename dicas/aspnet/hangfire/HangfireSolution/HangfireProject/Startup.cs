using Hangfire;
using HangfireProject.Extensions;
using HangfireProject.Filters;
using HangfireProject.Services.Background;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HangfireProject
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services
                .AddHangfire(c =>
                    c.UseInMemoryStorage()
                )
                .AddHangfireServer(options =>
                {
                    // Listagem das filas utilizadas no projeto
                    options.Queues = new[] { "one", "two", "recurring", "default" };
                });
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            // Adicionando todos os serviços para serem executados em background
            app.UseHangfireDashboard(options: new DashboardOptions
            {
                // Por padrão e questões de segurança,
                // apenas local requests são permitidos acessar o dashboard.
                // Portanto, adicionamos um filtro de autorização.
                // https://docs.hangfire.io/en/latest/configuration/using-dashboard.html#configuring-authorization
                Authorization = new[] { new HangfireAuthorizationFilter() },
            })
                .AddRecurringBackground()
                .AddOneTimeRunBackground(30)
                .AddEnqueuedBackground();

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                // Adicionando o endpoint /hangfire
                endpoints.MapHangfireDashboard();
            });
        }
    }
}
