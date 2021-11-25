# Perfomance C#

No nosso dia-a-dia utilizamos estruturas de repetição a todo momento para realizarmos operações de soma, encontramos o maior elemento em uma lista, ou até mesmo encontramos um objeto baseado em alguma propriedade. Neste contexto, qual a melhor forma de escrevermos nosso código? Utilizando for, foreach, LINQ? Utilizando List ou um IEnumerable?

Neste projeto realizamos um comparativo entre todas as opções acima. Caso queria saber o resultado, tem spoiler no final. Os testes realizados foram:

- Somar todos os números de uma List e um IEnumerable utilizando for, foreach e LINQ.
- Calcular a média de uma propriedade de uma Lista e de um IEnumerable de UserModel utilizando for, foreach e LINQ.
- Encontrar uma instância de um objeto UserModel em uma List e um IEnumerable utilizando for, foreach, FindAll e Where.

Quais são as suas apostas?

## Estrutura do Projeto

O projeto foi criado utilizando a versão .Net 5.0 e adicionamos referência ao package [BenchmarkDotNet](https://www.nuget.org/packages/BenchmarkDotNet/). Configura o código fonte abaixo.


- [Somar lista](PerformanceProject/Benchmark/IterateSumBenchmark.cs)
- [Calcular média](PerformanceProject/Benchmark/IterateAverageBenchmark.cs)
- [Encontrar instância](PerformanceProject/Benchmark/FindObjectBenchmark.cs)

## Spoiler

### Somar números de uma lista

O código com maior perfomance foi:

```csharp
private List<int> listInt;

/// <summary>
/// Traditional loop with Generic.List
/// </summary>
[Benchmark]
public void For_List()
{
	var sum = 0;
	for (int i = 0; i < listInt.Count; i++)
	{
		sum += listInt[i];
	}
}
```

<table>
<thead>
<tr><th colspan="6">Somar números de uma lista</th></tr>
<tr><th>Method</th><th>listSize</th><th>Mean</th><th>Error</th><th>StdDev</th><th>Rank</th></tr>
</thead>
<tbody>
<tr><td>For_List</td><td>50</td><td>55.11 ns</td><td>3.133 ns</td><td>0.172 ns</td><td>1</td></tr>
</tr><tr><td>Foreach_List</td><td>50</td><td>118.33 ns</td><td>30.096 ns</td><td>1.650 ns</td><td>2</td></tr>
<tr><td>Linq_Sum_IEnumerable</td><td>50</td><td>247.81 ns</td><td>6.799 ns</td><td>0.373 ns</td><td>3</td></tr>
<tr><td>Foreach_IEnumerable</td><td>50</td><td>273.15 ns</td><td>213.269 ns</td><td>11.690 ns</td><td>4</td></tr>
<tr><td>Linq_Sum_List</td><td>50</td><td>354.64 ns</td><td>18.081 ns</td><td>0.991 ns</td><td>5</td></tr>
<tr><td>For_IEnumerable</td><td>50</td><td>877.68 ns</td><td>12.990 ns</td><td>0.712 ns</td><td>6</td></tr>
</tbody>
</table>


### Calcular média baseado em uma propriedade de um objeto

O código com maior perfomance foi:

```csharp
private List<UserModel> listUserModel;

/// <summary>
/// Traditional loop with Generic.List
/// </summary>
[Benchmark]
public void For_List()
{
	var average = 0;
	for (int i = 0; i < listUserModel.Count; i++)
	{
		average += listUserModel[i].ExperienceYears;
	}
	average = average / listUserModel.Count;
}
```

<table>
<thead>
<tr><th colspan="6">Calcular média baseado em uma propriedade de um objeto</th></tr>
<tr><th>Method</th><th>listSize</th><th>Mean</th><th>Error</th><th>StdDev</th><th>Rank</th></tr>
</thead>
<tbody>
<tr><td>For_List</td><td>50</td><td>49.57 ns</td><td>1.536 ns</td><td>0.084 ns</td><td>1</td></tr>
<tr><td>Foreach_List</td><td>50</td><td>197.19 ns</td><td>68.753 ns</td><td>3.769 ns</td><td>2</td></tr>
<tr><td>Foreach_IEnumerable</td><td>50</td><td>508.16 ns</td><td>616.531 ns</td><td>33.794 ns</td><td>3</td></tr>
<tr><td>Linq_Sum_List</td><td>50</td><td>595.01 ns</td><td>250.902 ns</td><td>13.753 ns</td><td>4</td></tr>
<tr><td>Linq_Sum_IEnumerable</td><td>50</td><td>633.94 ns</td><td>326.952 ns</td><td>17.921 ns</td><td>5</td></tr>
<tr><td>For_IEnumerable</td><td>50</td><td>955.99 ns</td><td>49.111 ns</td><td>2.692 ns</td><td>6</td></tr>
</tbody>
</table>
</body>
</html>

### Encontrar uma instância de um objeto

O código com maior perfomance foi:

```csharp
private IEnumerable<UserModel> listUserModelEnumerable;

[Benchmark]
public void Where_IEnumerable()
{
	IEnumerable<UserModel> result = listUserModelEnumerable.Where(model => model.Name == targetUser);
}
```

<table>
<thead>
<tr><th colspan="6">Encontrar uma instância de um objeto</th></tr>
<tr><th>Method</th><th>listSize</th><th> Mean</th><th>Error</th><th>StdDev</th><th>Rank</th></tr>
</thead>
<tbody>
<tr><td>Where_IEnumerable</td><td>50</td><td>32.21 ns</td><td>34.33 ns</td><td>1.881 ns</td><td>1</td></tr>
<tr><td>Where_List</td><td>50</td><td>56.24 ns</td><td>53.42 ns</td><td>2.928 ns</td><td>2</td></tr>
<tr><td>Where_List_ToList</td><td>50</td><td>276.54 ns</td><td>37.13 ns</td><td>2.035 ns</td><td>3</td></tr>
<tr><td>For_List</td><td>50</td><td>290.06 ns</td><td>1,255.02 ns</td><td>68.792 ns</td><td>4</td></tr>
<tr><td>FindAll_List</td><td>50</td><td>312.87 ns</td><td>755.91 ns</td><td>41.434 ns</td><td>5</td></tr>
<tr><td>Where_IEnumerable_ToList</td><td>50</td><td>315.41 ns</td><td>80.26 ns</td><td>4.399 ns</td><td>5</td></tr>
<tr><td>Foreach_List</td><td>50</td><td>439.41 ns</td><td>143.14 ns</td><td>7.846 ns</td><td>6</td></tr>
<tr><td>Foreach_IEnumerable</td><td>50</td><td>597.59 ns</td><td>320.69 ns</td><td>17.578 ns</td><td>7</td></tr>
<tr><td>For_IEnumerable</td><td>50</td><td>1,218.41 ns</td><td>228.80 ns</td><td>12.542 ns</td><td>8</td></tr>
</tbody>
</table>