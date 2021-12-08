using Hangfire;
using HangfireProject.Services.Background;
using Microsoft.AspNetCore.Builder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HangfireProject.Extensions
{
    public static class BackgroundServices
    {
        /// <summary>
        /// Adiciona um serviço recorrente para ser executado a cada 1 minuto
        /// https://crontab.guru
        /// </summary>
        public static IApplicationBuilder AddRecurringBackground(this IApplicationBuilder app)
        {
            RecurringJob.AddOrUpdate("Logging a cada 1 minuto", () => ConsoleLogs.EnqueueToWriteInConsoleRecurring(),
                "*/1 * * * *");

            return app;
        }

        /// <summary>
        /// Adiciona um serviço para ser executado uma única vez após X segundos
        /// </summary>
        public static IApplicationBuilder AddOneTimeRunBackground(this IApplicationBuilder app, int seconds)
        {
            BackgroundJob.Schedule(() => ConsoleLogs.WriteInConsoleOne(),
                TimeSpan.FromSeconds(seconds));

            return app;
        }

        /// <summary>
        /// Adiciona um serviço na fila para ser executado assim que possível
        /// </summary>
        public static IApplicationBuilder AddEnqueuedBackground(this IApplicationBuilder app)
        {
            BackgroundJob.Enqueue(() => ConsoleLogs.WriteInConsoleTwo());

            return app;
        }
    }
}
