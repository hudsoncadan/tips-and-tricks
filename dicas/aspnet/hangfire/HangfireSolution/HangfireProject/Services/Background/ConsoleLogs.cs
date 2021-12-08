using Hangfire;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HangfireProject.Services.Background
{
    public static class ConsoleLogs
    {
        /// <summary>
        /// Executa o método na fila chamada "one"
        /// </summary>
        [Queue("one")]
        public static void WriteInConsoleOne()
        {
            Console.WriteLine("Writing from Queue One");
        }

        /// <summary>
        /// Executa o método na fila chamada "two"
        /// </summary>
        [Queue("two")]
        public static void WriteInConsoleTwo()
        {
            Console.WriteLine("Writing from Queue Two");
        }

        /// <summary>
        /// Executa o método na fila chamada "default"
        /// </summary>
        public static void WriteInConsoleRecurring()
        {
            Console.WriteLine("Writing from Queue default");
        }

        /// <summary>
        /// Executa o método na fila chamada "recurring"
        /// </summary>
        [Queue("recurring")]
        public static void EnqueueToWriteInConsoleRecurring()
        {
            BackgroundJob.Enqueue(() => ConsoleLogs.WriteInConsoleRecurring());
        }
    }
}
