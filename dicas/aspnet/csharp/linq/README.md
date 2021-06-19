# LINQ
Tradicionalmente, queries são representadas através de strings sem verificação de tipo em tempo de compilação ou até mesmo sem suporte ao IntelliSense. Diferentes linguagens foram desenvolvidas para os diferentes tipos de dados, for exemplo, banco de dados relacional, documentos XML, entre outros...

LINQ, Language Integrated Query, simplifica este cenário ao oferecer um modelo consistente para trabalhar com dados de diferentes fontes. Algumas características de LINQ:
- Sempre trabalha com objetos
- É recomendado que seja utilizado a **sintaxe de query** sempre que possível, e a **sintaxe de métodos** quando necessário; apesar de não haver diferença de performance em ambos.
- Uma query não é executada até que o desenvolvedor não a percorra com, por exemplo, uma declaração foreach.
## Conceitos
Todas as queries LINQ consistem em três partes:

1. Obter os dados
2. Criar a query
3. Executar a query

Observe o exemplo a seguir:
```csharp
// 1. Obter os dados
int[] numbers = new int[7] { 0, 1, 2, 3, 4, 5, 6 };

// 2. Criar a query
// numQuery é um IEnumerable<int>
var numQuery =
	from num in numbers
	where (num % 2) == 0
	select num;

// 3. Executar a query.
foreach (int num in numQuery)
{
	Console.Write("{0,1} ", num);
}
```
Exemplo de LINQ para localizar todos os clientes de uma base de dados que residem na cidade de Campinas.
```csharp
// 2. Criar a query: clientes na cidade de Campinas
IQueryable<Customer> custQuery =  
    from cust in db.Customers  
    where cust.City == "Campinas"  
    select cust;  
```
Se você é familiarizado com SQL, você percebeu nos exemplos acimas que a ordem das palavras chaves **from**, **where** e **select** são invertidas, se comparados com o SQL.
### Execução da Query
#### Execução Adiada
A query não é executada até o momento que o desenvolvedor interaja com a declaração **foreach**. Este conceito é conhecido como **deferred execution**.
#### Execução Imediata
É importante estar atento que funções de agregação forçam a query ser executada imediatamente, por exemplo, queries que executam **Count**, **Max**, **Average** ou então **First**. Estas queries são executadas imediatamentes, pois internamente, essas funções executam um **foreach**.
```csharp
// 2. Criar a query
var evenNumQuery =
    from num in numbers
    where (num % 2) == 0
    select num;

// 3. Executar a query
int evenNumCount = evenNumQuery.Count();
```
Outra opção para executar a query é chamar **ToList()** ou **ToArray()**.
```csharp
// 3. Executar a query
List<int> numQuery2 =
    (from num in numbers
     where (num % 2) == 0
     select num).ToList();

// 3. Executar a query
var numQuery3 =
    (from num in numbers
     where (num % 2) == 0
     select num).ToArray();
```
## Operações Básicas
Vamos considerar os seguintes dados:
```csharp
// 1. Obter os dados
List<Student> students = new List<Student>
{
   new Student {First="Svetlana", Last="Omelchenko", ID=111},
   new Student {First="Claire", Last="O'Donnell", ID=112},
   new Student {First="Sven", Last="Mortensen", ID=113},
   new Student {First="Cesar", Last="Garcia", ID=114},
   new Student {First="Debra", Last="Garcia", ID=115}
};
```
### OrderBy
```csharp
// 2. Criar a query
IEnumerable<Student> sortedStudents =
            from student in students
            orderby student.Last ascending, student.First ascending
            select student;
			
// 3. Executar a query
foreach (Student student in sortedStudents)
    Console.WriteLine(student.Last + " " + student.First);
```
O resultado será:
```html
Garcia Cesar
Garcia Debra
Mortensen Sven
O'Donnell Claire
Omelchenko Svetlana
```
### Group By
Agora vamos criar grupos e orderná-los. 

1. Inicialmente, a query ordena os nomes de todos os estudantes em ordem alfabética
2. Em seguida, agrupa os estudantes em grupos com a letra inicial do sobrenome
3. Por fim, ordena os grupos em ordem alfabética
```csharp
// 2. Criar a query
var sortedGroups =
	from student in students
	orderby student.Last, student.First
	group student by student.Last[0] into newGroup
	orderby newGroup.Key
	select newGroup;
	
// 3. Executar a query
foreach (var studentGroup in sortedGroups)
{
	Console.WriteLine(studentGroup.Key);
	foreach (var student in studentGroup)
	{
		Console.WriteLine("   {0}, {1}", student.Last, student.First);
	}
}

```
O resultado será:
```html
G
   Garcia, Cesar
   Garcia, Debra
M
   Mortensen, Sven
O
   O'Donnell, Claire
   Omelchenko, Svetlana
```
### Joins
#### Inner Join
Para o primeiro caso, vamos analisar uma lista de animais e seus respectivos donos.
```csharp
// 1. Obter os dados
Pessoa magnus = new Pessoa { Nome = "Magnus", Sobrenome = "Hedlund" };
Pessoa terry = new Pessoa { Nome = "Terry", Sobrenome = "Adams" };
Pessoa charlotte = new Pessoa { Nome = "Charlotte", Sobrenome = "Weiss" };
Pessoa arlene = new Pessoa { Nome = "Arlene", Sobrenome = "Huff" };
Pessoa rui = new Pessoa { Nome = "Rui", Sobrenome = "Raposo" };

AnimalEstimacao barley = new AnimalEstimacao { Nome = "Barley", Dono = terry };
AnimalEstimacao boots = new AnimalEstimacao { Nome = "Boots", Dono = terry };
AnimalEstimacao whiskers = new AnimalEstimacao { Nome = "Whiskers", Dono = charlotte };
AnimalEstimacao bluemoon = new AnimalEstimacao { Nome = "Blue Moon", Dono = rui };
AnimalEstimacao daisy = new AnimalEstimacao { Nome = "Daisy", Dono = magnus };

List<Pessoa> pessoas = new List<Pessoa> { magnus, terry, charlotte, arlene, rui };
List<AnimalEstimacao> animais = new List<AnimalEstimacao> { barley, boots, whiskers, bluemoon, daisy };

// 2. Criar a query
var innerJoinQuery = from pessoa in pessoas
	join animal in animais on pessoa equals animal.Dono
	select new { Dono = pessoa.Nome, Animal = animal.Nome };
	
// 3. Executar a query
foreach(var result in innerJoinQuery)
{
	Console.WriteLine($"\"{result.Dono}\" é dono do {result.Animal}");
}
```
Observe que a Pessoa Arlene não possui nenhum animal, portanto não foi incluída no resultado.
```html
"Magnus" é dono do Daisy
"Terry" é dono do Barley
"Terry" é dono do Boots
"Charlotte" é dono do Whiskers
"Rui" é dono do Blue Moon
```
#### Join com Chave Composta
O exemplo a seguir utiliza uma lista de Funcionários e Estudantes. O objetivo é selecionar os funcionários que também são estudantes.
```csharp
// 1. Obter os dados
List<Funcionario> funcionarios = new List<Funcionario> {
	new Funcionario { Nome = "Terry", Sobrenome = "Adams", ID = 522459 },
	new Funcionario { Nome = "Charlotte", Sobrenome = "Weiss", ID = 204467 },
	new Funcionario { Nome = "Magnus", Sobrenome = "Hedland", ID = 866200 },
	new Funcionario { Nome = "Vernette", Sobrenome = "Price", ID = 437139 } 
};

List<Estudante> estudantes = new List<Estudante> {
	new Estudante { Nome = "Vernette", Sobrenome = "Price", ID = 9562 },
	new Estudante { Nome= "Terry", Sobrenome = "Earls", ID = 9870 },
	new Estudante { Nome= "Terry", Sobrenome = "Adams", ID = 9913 } 
};

// 2. Criar a query
IEnumerable<string> query = from funcionario in funcionarios
							join estudante in estudantes
							on new { funcionario.Nome, funcionario.Sobrenome }
							equals new { estudante.Nome, estudante.Sobrenome }
							select funcionario.Nome + " " + funcionario.Sobrenome;

// 3. Executar a query
foreach (string name in query)
	Console.WriteLine(name);
```
O resultado será:
```html
Terry Adams
Vernette Price
```
#### Join com Grouped Join
Considerando três lista: pessoas, cachorros e gatos. Inicialmente vamos selecionar todos os animais com os seus respectivos donos e armazená-los em grupos. Com os grupos criados, vamos selecionar apenas as pessoas que possuem animais.

Atenção para o comportamento do Group Join: Um group join de Pessoas e Cachorros, por exemplo, irá resultar em cada Pessoa contendo uma coleção de Cachorros, mesmo que a coleção esteja vazia.
```csharp
// 1. Obter os dados
Pessoa joao = new Pessoa { Nome = "João" };
Pessoa maria = new Pessoa { Nome = "Maria" };
Pessoa jose = new Pessoa { Nome = "José" };
Pessoa antonio = new Pessoa { Nome = "Antônio" };
Pessoa douglas = new Pessoa { Nome = "Douglas" };
Pessoa ana = new Pessoa { Nome = "Ana" };

Cat barley = new Cat { Name = "Barley", Owner = maria };
Cat boots = new Cat { Name = "Boots", Owner = maria };
Cat whiskers = new Cat { Name = "Whiskers", Owner = jose };
Cat bluemoon = new Cat { Name = "Blue Moon", Owner = jose };
Cat daisy = new Cat { Name = "Daisy", Owner = douglas };

Dog barth = new Dog { Name = "Barth", Owner = maria };
Dog lipe = new Dog { Name = "Lipe", Owner = maria };
Dog theo = new Dog { Name = "Theo", Owner = jose };
Dog mayla = new Dog { Name = "Mayla", Owner = jose };
Dog tob = new Dog { Name = "Tob", Owner = jose };

List<Pessoa> people = new List<Pessoa> { joao, maria, jose, antonio, douglas, ana };
List<Cat> cats = new List<Cat> { barley, boots, whiskers, bluemoon, daisy };
List<Dog> dogs = new List<Dog> { barth, lipe, theo, mayla, tob };

// 2. Criar a query
var groupedJoin = from pessoa in people
				  join dog in dogs on pessoa equals dog.Owner into pessoaDog
				  join cat in cats on pessoa equals cat.Owner into pessoaCat
				  where pessoaDog.Count() > 0 || pessoaCat.Count() > 0
				  select new
				  {
				   Dono = pessoa.Nome,
				   Pets = pessoaDog,
				   Cats = pessoaCat,
				   Animais = pessoaDog.Select(d => d.Name)
								.Concat(pessoaCat.Select(c => c.Name))
				  };

// 3. Executar a query
foreach (var pessoa in groupedJoin)
{
	var totalAnimais = pessoa.Animais.Count();
	Console.WriteLine($"{pessoa.Dono} possui {totalAnimais} {(totalAnimais == 1 ? "animal" : "animais")}: {string.Join(", ", pessoa.Animais)}\n");
}
```
O resultado será:
```html
Maria possui 4 animais: Barth, Lipe, Barley, Boots
José possui 5 animais: Theo, Mayla, Tob, Whiskers, Blue Moon
Douglas possui 1 animal: Daisy
```
#### Left Outer Join
Para este exemplo, iremos utilizar a listagem de pessoas e cachorros. Iremos pesquisar todas as pessoas, independentemente se possuem cachorros. Portanto, utilizaremos um left outer join.

Atenção especial para a declaração da query. Utilizamos dois formas de construção: Utilizando Grouped Join e a cláusula Where. Ambas sintaxes funcionam.
```csharp
// 1. Obter os dados
Pessoa joao = new Pessoa { Nome = "João" };
Pessoa maria = new Pessoa { Nome = "Maria" };
Pessoa jose = new Pessoa { Nome = "José" };
Pessoa antonio = new Pessoa { Nome = "Antônio" };
Pessoa douglas = new Pessoa { Nome = "Douglas" };
Pessoa ana = new Pessoa { Nome = "Ana" };

Dog barth = new Dog { Name = "Barth", Owner = maria };
Dog lipe = new Dog { Name = "Lipe", Owner = maria };
Dog theo = new Dog { Name = "Theo", Owner = jose };
Dog mayla = new Dog { Name = "Mayla", Owner = jose };
Dog tob = new Dog { Name = "Tob", Owner = jose };

List<Pessoa> people = new List<Pessoa> { joao, maria, jose, antonio, douglas, ana };
List<Dog> dogs = new List<Dog> { barth, lipe, theo, mayla, tob };

// 2. Criar a query utilizando groupedJoin
var leftOuterJoinGrouped = from pessoa in people
			join dog in dogs on pessoa equals dog.Owner into dogGroup
			from dogInGroup in dogGroup.DefaultIfEmpty()
			select new { Dono = pessoa.Nome, Cachorro = dogInGroup?.Name ?? String.Empty };

// 2. Criar a query utilizando Where
var leftOuterJoinWhere = from pessoa in people
			from dog in dogs
				.Where(x => x.Owner == pessoa).DefaultIfEmpty()
			select new { Dono = pessoa.Nome, Cachorro = dog?.Name ?? String.Empty };

// 3. Executar a query
foreach (var pessoa in leftOuterJoinWhere)
{
	Console.WriteLine($"{pessoa.Dono}: {pessoa.Cachorro}");
}
```
O resultado será:
```html
João:
Maria: Barth
Maria: Lipe
José: Theo
José: Mayla
José: Tob
Antônio:
Douglas:
Ana:
```
#### Exemplo Extra
Para finalizar, vamos considerar uma lista de produtos relacionados a categorias. Selecionaremos todas as categorias e os seus respectivos produtos.
```csharp
 // 1. Obter os dados
List<Category> categories = new List<Category>()
 {
	 new Category(){ Name="Beverages", ID=001 },
	 new Category(){ Name="Condiments", ID=002 },
	 new Category(){ Name="Vegetables", ID=003 },
	 new Category() {  Name="Grains", ID=004 },
	 new Category() {  Name="Fruit", ID=005 }
 };

List<Product> products = new List<Product>()
{
   new Product{ Name="Cola",  CategoryID=001 },
   new Product{ Name="Tea",  CategoryID=001 },
   new Product{ Name="Mustard", CategoryID=002 },
   new Product{ Name="Pickles", CategoryID=002 },
   new Product{ Name="Carrots", CategoryID=003 },
   new Product{ Name="Bok Choy", CategoryID=003 },
   new Product{ Name="Peaches", CategoryID=005 },
   new Product{ Name="Melons", CategoryID=005 },
 };

// 2. Criar a query
var query = from category in categories
			join product in products on category.ID equals product.CategoryID into pg
			where pg.Count() > 0
			orderby category.Name
			select new
			{
				Category = category.Name,
				Products = (from p in pg
							orderby p.Name descending
							select p.Name)
			};

// 3. Executar a query
foreach (var result in query)
{
	Console.Write($"{result.Category}:\n  {string.Join(", ", result.Products)}\n\n");
}
```
O resultado será:
```html
Beverages:
  Tea, Cola

Condiments:
  Pickles, Mustard

Fruit:
  Peaches, Melons

Vegetables:
  Carrots, Bok Choy
```