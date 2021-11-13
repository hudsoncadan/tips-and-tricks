# Testes em Apps Flutter

Quanto mais funcionalidades o aplicativo tem, mais difícil é realizar testes manualmente. Portanto, testes automatizados garantem que o aplicativo apresente o comportamento esperado pelos usuários. 

Em Flutter podemos destacar 3 tipos de testes:

- __Unit tests__ testam uma única função, método ou classe.
- __Widget tests__ testam Widgets, conforme o nome sugere.
- __Integration tests__ testam o aplicativo como um todo, ou grande parte dele.

Neste documento vamos discutir e apresentar um aplicativo que realiza Unit Tests e Widget Tests.

## Estrutura do Projeto

Veja abaixo os requisitos que este aplicativo apresenta. Este projeto foi desenvolvido seguindo a arquitetura proposta pelo [package GET](https://pub.dev/packages/get).

### Página Inicial ([HomeView](lib/app/modules/home))
- Lista de Itens de um Pedido
- Na parte superior, um Card informando a Quantidade de Itens e outro com o Total dos itens
- Na parte inferior, um Botão para Adicionar mais itens
- Caso a lista esteja vazia, deve aparecer um Widget informando o usuário que a lista está vazia

<img src="https://user-images.githubusercontent.com/29586519/140940374-9c5793d0-e857-4364-bb64-dafe86395cf3.png">

### Página de Erro (ErrorView)
- Existe uma simulação de uma chamada em uma API
- Caso haja erro no retorno da API, o usuário é direcionado para a página de Erro

## Testes

Para a elaboração dos testes, foi utilizado o [package mocktail](https://pub.dev/packages/mocktail). Considerando os requisitos do aplicativo neste projeto, foram criados os seguintes testes:

- __[Unit Tests](test/order_model_test.dart)__ para verificar se a lógica da classe OrderModel está correta. Os seguintes cenários foram testados:
  - Total de um pedido com 4 itens
  - Total de um pedido com 1 item, e este mesmo pedido tem sua quantidade atualizada para 5 itens
  - Total de um pedido com 1 item, e este mesmo item tem sua quantidade atualizada para 5 itens
  - Quantidade de itens incluídos em um pedido
  - Tentativa ao atualizar um item de um pedido, porém o item não é encontrado dentro do pedido

- __[Widget Tests](test/widget_test.dart)__ para verificar se o comportamento do Widget está correto. Os seguintes cenários foram testados:
  - Quando a lista de itens estiver vazia, aparecer mensagem informando o usuário 
  - Exibir lista quando possuir itens no pedido
  - Direcionar o usuário para a página de Erro quando não houver sucesso na resposta da API

## Source
- [Testing Flutter apps](https://flutter.dev/docs/testing)
- [Package Mocktail](https://pub.dev/packages/mocktail)