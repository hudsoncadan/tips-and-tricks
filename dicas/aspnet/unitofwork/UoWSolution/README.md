# Repository Pattern com Unit of Work

Neste projeto iremos discutir e apresentar uma proposta de solução para a implementação do padrão Repository com Unit of Work.

Veja abaixo alguns pontos importantes sobre ambas propostas.

## Generic Repository Pattern

Com o padrão Repository é possível criar uma camada de abstração entre o banco de dados e as regras de negócios. Iremos implementar todas as regras de acesso ao banco de dados na camada de Repository, e não nos Controllers.

Através do Generic Repository Pattern será possível implementar as operações básicas de acesso ao banco de dados (CRUD) para todas as entidades em uma única classe.

## Unit of Work, o quê?

Se pesquisarmos definições e implementações sobre Unit of Work, encontraremos várias propostas em artigos pela internet e livros. Em resumo, dizemos que Unit of Work é um processo de "transação de negócios", mas que não significa muita coisa para nós. 

Na prática, através do Unit of Work, conseguimos realizar uma única transação no banco de dados (um commmit, por exemplo), mesmo após termos alterados vários registros em várias tabelas. Se alguma transação falhar, podemos realizar o roll back de todas as modificações.

## Exemplo

Criamos uma solução com um projeto Web API. Abaixo veja características e estrutura do projeto. 

_Utilize os links para acessar diretamente as classes. E atenção, este projeto apresenta uma proposta para fins didáticos._

- Possui um banco de dados em memória
- Possui dois Controllers: [ProductController](UoWApi/Controllers/ProductController.cs) e [CategoryController](UoWApi/Controllers/CategoryController.cs)
- Em cada Controller é injetado um [IUnitOfWork](UoWApi/Configuration/IUnitOfWork.cs)
- Em [UnitOfWork](UoWApi/Configuration/UnitOfWork.cs) é criado uma instância para cada Repository: [IProductRepository](UoWApi/Services/Interfaces/IProductRepository.cs) e [ICategoryRepository](UoWApi/Services/Interfaces/ICategoryRepository.cs)
- [ProdutoRepository](UoWApi/Services/Repositories/ProductRepository.cs) e [CategoryRepository](UoWApi/Services/Repositories/CategoryRepository.cs) implementa um [IGenericRepository](UoWApi/Services/Interfaces/IGenericRepository.cs), com operações CRUD
- As operações CRUD são implementadas em [GenericRepository](UoWApi/Services/Repositories/GenericRepository.cs)
- [IProdutoRepository](UoWApi/Services/Interfaces/IProductRepository.cs) possui um método extra, personalizado, implementado em [ProductRepository](UoWApi/Services/Repositories/ProductRepository.cs)

Com esta estrutura observe que:

- As operações CRUD estão implementadas em [GenericRepository](UoWApi/Services/Repositories/GenericRepository.cs) e desta forma evitamos código duplicados nos demais Repositories
- Nós chamamos o seguinte código nas classes Controllers, implemetado em [BaseController](UoWApi/Controllers/BaseController.cs). Desta forma temos controle do momento exato em que a operação _commit()_ deverá ser realizada

[BaseController](UoWApi/Controllers/BaseController.cs):

```csharp
uow.CompleteAsync();
```

[UnitOfWork](UoWApi/Configuration/UnitOfWork.cs):
```csharp

public class UnitOfWork : IUnitOfWork, IDisposable
{
	public async Task<int> CompleteAsync()
	{
		return await _context.SaveChangesAsync();
	}
}
```


Clone a solução e compile localmente. É possível realizar testes através do Swagger disponível na API.


