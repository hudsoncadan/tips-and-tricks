# Flutter
Com o avanço e a popularidade de aplicativos desenvolvidos em Flutter, surge a necessidade de discutir temas como __Gerenciamento de Estado__, __Injenção de Dependências__ e __Roteamento__.

Em resumo, podemos conceituar esses três pontos da seguinte forma:

- __Gerenciamento de Estado__: se pesquisarmos este termo encontraremos a definição que refere-se ao estado de uma aplicação. Isso não significa muita coisa, então na prática podemos exemplificar da seguinte maneira: imagine um aplicativo que exibe uma lista de pedidos recebidos, e até mesmo um valor total exibido no canto superior do aplicativo. Quando esta lista de pedidos for atualizada, o total também deve ser atualizado. Isso significa que o estado da aplicação mudou e os dados devem ser atualizados na tela para o usuário. Esse conceito de atualização refere-se gerenciar o estado do aplicativo. Bem mais prático com o exemplo, não?

- __Injenção de Dependências__: é um padrão utilizado para evitar o alto nível de acoplamento entre as classes. Vamos utilizar o mesmo exemplo do item anterior: Você desenvolvedor deseja exibir o valor total da lista de pedidos em várias telas do seu aplicativo. Imagine ter que passar a propriedade "valorTotal" no construtor de todas as telas para poder exibir. Podemos dizer "ninguém merece", não é mesmo? Então para contornar a situação, podemos injetar "dentro de cada tela" o valorTotal que está declarado em apenas um lugar. Uma vez definido, sempre acessível. 

- __Roteamento__ possui um conceito simples no aplicativo: navegar entre diferentes telas. Afinal, qual aplicativo não faz isso?! Porém esta tarefa pode se tornar uma dor de cabeça para o desenvolvedor. Como eu sou super fan de exemplos, vamos lá: o usuário está na tela inicial visualizando um cardápio (tela 1), escolhe o produto (tela 2), seleciona os acompanhamentos (tela 3), verifica a revisão do item escolhido (tela 4) e ao enviar o pedido deseja voltar para a tela do cardápio (tela 1). Pronto... dor de cabeça. Como voltar todas as telas e manter o usuário na tela inicial?

E agora, como manter tudo isso organizado? E tem mais: conhecendo Flutter, vamos escrevendo código e nossas classes ficam "enooormes", sim, "enooormes"... É view, regra de negócio, chamada em API; tudo dentro de uma estrutura Tree. E agora?

## Package GET

Eu quero apresentar o package GET que, me enche de orgulho por ser desenvolvido por um brasileiro e, resolve MUITO a minha vida como programador. Quem não gosta de produtividade né?! Os links estão disponíveis no final deste documento, na seção Source.

Este package é capaz de solucionar todas as questões apresentadas anteriormente. Então veremos neste documento:
- A estrutura de um projeto com o package GET;
- Trechos de códigos para os 3 pontos apresentados nos exemplos.

### Estrutura de projeto com GET e Injeção de Dependência
![image](https://user-images.githubusercontent.com/29586519/138597656-08a6b9f5-2a50-48d9-9308-88262f49bf11.png)

Vamos analisar o diagrama. Segue o fluxo:

- O aplicativo inicia no método main();
```dart
void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
```

- As rotas são carregadas através do arquivo __AppPages.routes__; 
	- As rotas são nomeadas e podem ser utilizadas através do Flutter Web;
	- Para exemplificar, as rotas podem ser:
		- _/cardapio_ para exibir a tela com a listagem do Cardápio;
		- _/produto/id_ para exibir detalhes de um produto específico;
		
Veja o trecho de código do arquivo __AppPages.routes__ que disponibiliza a tela Home no aplicativo.

```dart
GetPage(
  name: _Paths.HOME,
  page: () => HomeView(),
  binding: HomeBinding(),
)
```

As propriedades representam:
 - __name__: o nome da rota;
 - __page__: a classe View (Stateless ou Stateful) que representa a tela;
 - __binding__: configuração da Injeção de Dependência. 
	
Vamos analisar de perto cada propriedade e como tudo está conectado.

- name: _Paths.HOME é uma constante com o seguinte valor:
```dart
static const HOME = '/home';
```
	
- page: () => HomeView() é a classe Stateless ou Stateful que representa a tela no aplicativo. No código abaixo podemos ver como HomeView é declarado. HomeView extends _GetView_ que representa um Widget Stateless e está vinculada à _HomeController_. GetView também disponibiliza uma propriedade __controller__ para acessar todo o conteúdo do Controller associado. Você verá um exemplo no final deste documento.

```dart
class HomeView extends GetView<HomeController> {
}
```

- binding: HomeBinding() realiza a injeção de dependência. É o vínculo entre View e Controller. Observe que a classe HomeController é injetada através do __Get.lazyPut__ . HomeController possui as regras de negócios para a tela HomeView. Importante destacar que a HomeController é injetada apenas no momento que for solicitada pelo aplicativo, fornecendo desta forma otimização da memória.
	
```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
```

Resumindo, temos:
 - View -> Binding -> Controller;
	
Em outros termos:
 - Tela -> Injeção de Dependência -> Regras de Negócio.

Eu sei que pode parecer código espalhado para todo lado, mas eu discordo do que parece. Na verdade é tudo bastante organizado. Realmente é pouco código se comparado com outros packages disponíveis no mercado. E o mais interessante de tudo é que tudo pode ser automaziado com o GET CLI.

Utilizando o comando abaixo toda a estrutura mencionada até agora é criada automaticamente. Seu dever é apenas criar a tela e as regras de negócios.

```
get create page:home
```

### Roteamento
Navegação entre telas dentro do aplicativo. Simples com o package GET. Vou direto aos exemplos. E preste atenção que é possível navegar sem o __context__.

Navegar para uma tela:
```dart
Get.toNamed("/NextScreen");
```
Fechar a tela atual:
```dart
Get.back();
```

Fechar a tela atual e abrir outra:
```dart
Get.offNamed("/SecondScreen");
```

Navegar de volta para a primeira tela:
```dart
 Get.until((route) => route.isFirst);
```

### Gerenciamento de Estado
Com o package GET é possível trabalhar de forma reativa, ou seja, se uma variável da sua regra de negócio é alterada, a tela é atualizada automaticamente.

Na classe HomeController, __count__ é declarado com a extensão __.obs__, tornando-o reativo.

```dart
class HomeController extends GetxController {

  final count = 0.obs;
  
  void increment() => count.value++;
}
```

Observe que o Widget __Obx__ torna o seu widget filho Text também reativo, ou seja, sempre que o valor de count for alterado, o Text será atualizado automaticamente.

```dart
Column(
	children: [
	  Obx(
		() => Text(
		  controller.count.value.toString(),
		  style: TextStyle(fontSize: 20),
		),
	  ),
	  ElevatedButton(
		onPressed: controller.increment,
		child: Text('Increment'),
	  )
	],
  )
```

## Exemplo repository

Neste repository está disponível um código apenas para apresentar a estrutura de um projeto flutter com o package GET. Abaixo as descrições de cada View. Lembrando que cada view possui os seus respectivos Controllers e Bindings.

- __HomeView__ com um contador implementado com o package GET.
- __AboutView__ apenas para demonstrar a navegação.
	
## Source
- [Package GET](https://pub.dev/packages/get) 
- [GET CLI](https://github.com/jonataslaw/get_cli)
