# Razor Syntax
Razor tem suporte ao C# e utiliza o símbolo @ para alternar	de HTML para C#. Portanto, Razor avalia o conteúdo C# e renderiza para HTML.
## Expressões Razor Implícitas
Expressões Razor Implícitas começam com o símbolo @ e são seguidas por código C#:
```csharp
<p>@DateTime.Now</p>
<p>@DateTime.IsLeapYear(2016)</p>
<p>@await DoSomething("hello", "world")</p>
```
## Expressões Razor Explícitas
Expressões Razor Explícitas são formadas por **@()**. Qualquer conteúdo dentro do parênteses será renderizado para a saída HTML.
```csharp
<p>Last week this time: @(DateTime.Now - TimeSpan.FromDays(7))</p>
```
O cálculo será interpretado e renderizado:
```html
Last week this time: 27/05/2021 12:13:29
```
## Comparando Expressões Implícitas x Explícitas
Considerando o exemplo acima, vamos utilizar o mesmo código, porém utilizando Expressões Implícitas:
```csharp
<p>Last week this time: @DateTime.Now - TimeSpan.FromDays(7)</p>
```
Observe que agora não há o uso dos parênteses, portanto apenas **@DateTime.Now** será interpretado. O restante será renderizado como texto simples. O resultado será: 
```html
Last week this time: 03/06/2021 12:16:56 - TimeSpan.FromDays(7)
```
Outro exemplo interessante, trabalhando com objetos:
```csharp
@{
	var joe = new { Age = 33 };
}
<p>Age@(joe.Age)</p>
<p>Age@joe.Age</p>
```
Será renderizado:
```html
Age33
Age@joe.Age
```
Observe que no primeiro caso **Age@(joe.Age)**, com a utilização de expressões explícitas, o objeto **joe** foi reconhecido e renderizado corretamente.
## Blocos de código
Conforme último exemplo, é possível criar blocos de código utilizando **@{ }**, e ainda declarar funções locais.
```csharp
@{
    void RenderName(string name)
    {
        <p>Name: <strong>@name</strong></p>
    }

    RenderName("Mahatma Gandhi");
    RenderName("Martin Luther King, Jr.");
}
```
Será renderizado:
```html
Name: Mahatma Gandhi

Name: Martin Luther King, Jr.
```
### Tudo junto e misturado
É possível complicar um pouco a situação e transitar entre HTML e C#.
```csharp
@{
    var inCSharp = true;
    <p>Agora em HTML, antes em C# @inCSharp</p>
}
```
Será renderizado:
```html
Agora em HTML, antes em C# True
```
Conheça mais exemplos em [Transições Implícitas e Explícitas](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor?view=aspnetcore-5.0#razor-code-blocks).
## Estruturas de Controle
Estruturas de Controle são extensões dos Blocos de Código. Conheça mais exemplos na [documentação oficial](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor?view=aspnetcore-5.0#control-structures).
### Condicionais @if, else if, else, and @switch
```csharp
@{
	var value = 3;
}
@if (value % 2 == 0)
{
    <p>O valor é par.</p>
}
else if (value >= 1337)
{
    <p>O valor é maior ou igual a 1337.</p>
}
else
{
    <p>O valor é impar e menor do que 1337.</p>
}
```
Será renderizado:
```html
O valor é impar e menor do que 1337.
```
### Looping @for, @foreach, @while, and @do while
```csharp
@{
	var people = new[]
	{
	new { Name = "João", Age = 31 },
	new { Name = "Maria", Age = 32 }
};
}
@for (var i = 0; i < people.Length; i++)
{
	var person = people[i];
	<p>Nome: <strong>@person.Name</strong>, Idade: <strong>@person.Age</strong></p>
}
```
Será renderizado:
```html
Nome: João, Idade: 31
Nome: Maria, Idade: 32
```
### @using
Em C#, ao utilizar a declaração @using é garantido que o objeto seja fechado (Disposed).
```csharp
@using (Html.BeginForm())
{
	<div>
		Email: <input type="email" id="Email" value="">
		<button>Register</button>
	</div>
}
```
Será renderizado:
```html

<form action="..." method="...">
	<div>
		Email: <input type="email" id="Email" value="">
		<button>Register</button>
	</div>
	<input name="__RequestVerificationToken" type="hidden" value="..." />
</form>
```
### @try, catch, finally
```csharp
@try
{
    throw new InvalidOperationException("Exceção foi lançada.");
}
catch (Exception ex)
{
    <p>Mensagem da exceção: @ex.Message</p>
}
finally
{
    <p>Declaração do finally.</p>
}
```
Será renderizado:
```html
Mensagem da exceção: Exceção foi lançada.
Declaração do finally.
```
## Source:
[Razor syntax reference for ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/razor?view=aspnetcore-5.0)