# Flutter Heart Animation

A proposta deste projeto é exibir uma lista de imagens, semelhante ao Instagram, com uma animação de like no duplo toque do usuário em cada imagem.

É importante destacar que, com a arquitetura apresentada neste projeto, as animações são realizadas em Stateless Widgets.

<img src="https://user-images.githubusercontent.com/29586519/142081234-962a2a0b-1bb4-444f-8455-91ddb785bb1e.gif" width="35%">

## Estrutura do Projeto

Este projeto foi desenvolvido seguindo a arquitetura proposta pelo [package GET](https://pub.dev/packages/get):
- [HomeView](lib/app/modules/home/views/home_view.dart): Tela inicial com uma listagem de Imagens.
- [HeartWidget](lib/app/modules/home/widgets/heart/heart_widget.dart): Widget que representa um ícone de coração com uma animação. Cada imagem da lista possui um HeartWidget vinculado.
- [HeartController](lib/app/modules/home/widgets/heart/heart_controller.dart): Controller vinculado a cada HeartWidget. Neste controller estão configurados os objetos referentes à animação.

## Source

- [Package GET](https://pub.dev/packages/get)