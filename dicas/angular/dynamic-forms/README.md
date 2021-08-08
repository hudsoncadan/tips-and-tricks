# Simulação de Formulário Dinâmico

Projeto Angular criado com o objetivo de simular a criação de formulários dinamicamente. Acesse o projeto através do link [https://angular-dynamicform.web.app/](https://angular-dynamicform.web.app/).

## Estrutura do Projeto

Este projeto está organizado dentro do App Module com dois Services e dois Components. Segue o diagrama que representa a estrutura do projeto.

![Simulação de Formulário Dinâmico](https://github.com/hudsoncadan/tips-and-tricks/blob/master/dicas/angular/dynamic-forms/src/assets/Estrutura.png)

### Services
**QuestionService** é o ponto de entrada da aplicação. Este Service é responsável por trazer do back-end as perguntas que serão exibidas dinamicamente para o usuário. O Service é injetado no componente *[AppComponent](https://github.com/hudsoncadan/tips-and-tricks/tree/master/dicas/angular/dynamic-forms/src/app/components)*.

Neste contexto, o Service simula um retorno de uma API com um delay de dois segundos.

**QuestionControlService** é injetado no componente *[DynamicFormComponent](https://github.com/hudsoncadan/tips-and-tricks/tree/master/dicas/angular/dynamic-forms/src/app/components)*. Este Service é responsável por percorrer o array de perguntas carregadas do back-end e converter cada pergunta em um FormGroup. Portanto, cada FormGroup representa uma Pergunta que será exibida para o usuário final.

### Components

**DynamicFormComponent** representa o Formulário que conterá todas as perguntas exibidas para o usuário. Este componente recebe como *Input* uma lista de *[QuestionBase](https://github.com/hudsoncadan/tips-and-tricks/tree/master/dicas/angular/dynamic-forms/src/app/models)* e através do *[QuestionControlService](https://github.com/hudsoncadan/tips-and-tricks/tree/master/dicas/angular/dynamic-forms/src/app/services)* (comentado anteriormente) irá converter cada pergunta em um FormGroup.

**DynamicFormQuestionComponent** representa uma Pergunta. É neste componente que o elemento DOM é criado e exibido para o usuário final.