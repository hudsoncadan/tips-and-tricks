# Hangfire
Uma maneira fácil para executar processamento em background com .NET. Documentação disponível no site [www.hangfire.io](https://www.hangfire.io/).

É possível adicionar serviços para serem executados assim que possível, agendar ou até mesmo serviços recorrentes.

## Estrutura do Projeto
Este repository apresenta um simples projeto para demonstração de serviços em background. Ao iniciar o projeto, o dashboard do Hangfire será carregado e é possível acompanhar os serviços em execução e/ou que foram executados.

Caso queira executar o projeto, recomendo:
- Fazer o clone do repository em sua máquina local e executar, ou;
- Caso utilize __Docker__, deixei disponível uma imagem do projeto para utilização. Execute o comando abaixo e acesse _url:8080/hangfire_.

```
docker run -d --rm -p 8080:80 hudsoncadan/hangfire-demo
```

As classes utilizadas são:

### [Startup](HangfireProject/Startup.cs)

Responsável por:
 - Declarar as queues (filas) que receberação os serviços a serem executados;
 - Incluir os serviços que devem ser executados

```csharp
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
```

### [BackgroundServices](HangfireProject/Extensions/BackgroundServices.cs)

Declara os métodos de extensão para serem chamados na classe [Startup.cs](HangfireProject/Startup.cs).

```csharp
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
```

### [ConsoleLogs](HangfireProject/Services/Background/ConsoleLogs.cs)

Declara os métodos que representam os serviços a serem executados. Observe que em cada método possui um [QueueAttribute](https://docs.hangfire.io/en/latest/background-processing/configuring-queues.html) para indicar em qual fila inserir cada serviço.

```csharp
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
```
