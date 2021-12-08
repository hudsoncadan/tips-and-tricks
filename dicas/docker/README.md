# Docker
Comandos Básicos mais utilizados e descritos resumidamente. O objetivo aqui não é abordar conceitos, e sim, um "quick reminder" dos comandos.
## Images
- [__docker image ls__](https://docs.docker.com/engine/reference/commandline/image/) Lista todas as imagens.
- [__docker images__](https://docs.docker.com/engine/reference/commandline/images/) Lista todas as imagens.
- [__docker rmi__](https://docs.docker.com/engine/reference/commandline/images/) Remove uma ou mais imagens.
- [__docker rmi $(docker images -aq)__](https://docs.docker.com/engine/reference/commandline/images/) Remove todas as imagens. A flag __-a__ significa listar todas as Imagens; e a flag __-q__ exibir apenas os IDs das Imagens.
- [__docker build -t tagname .__](https://docs.docker.com/engine/reference/commandline/build/) Cria uma _Imagem_ a partir de um arquivo _Dockerfile_.
- [__docker run__](https://docs.docker.com/engine/reference/commandline/run/) Cria e Inicia um _Container_ a partir de uma _Imagem_.

__Flags para o comando docker run__

- __-d__ Inicia um _Container_ no modo _detach_, ou seja, o _Container_ é executado em background.
- __--rm__ Automaticamente remove o _Container_ quando ele for finalizado.
- __-p__ Publica a porta do _Container_ para o _Host_. Para entender mais sobre Ports, veja a seção abaixo [Network, Ports](#ports).
- __--network__  Nome da Network. Veja mais sobre _Network_ na seção abaixo.
- __--name__ Nome desejado para o _Container_.

Exemplo: 
```
docker run -d --rm -p 8080:80 some-content-nginx
```

Com o comando acima, podemos interpretá-lo da seguinte forma: 
- Iniciar o container a partir da imagem some-content-nginx
- Executá-lo em background
- Para ser removido assim que o _Container_ for finalizado
- Os usuários irão acessar o _Container_ a partir da _Porta do Host_ 8080 e serão redirecionados para a Porta 80 do _Container_. Para entender mais sobre Ports, veja a seção abaixo [Network, Ports](#ports).

## Containers
- [__docker ps -a__](https://docs.docker.com/engine/reference/commandline/ps/) Lista todos os _Container_. A flag _-a_ inclui os _Containers_ que estão parados.
- [__docker start__](https://docs.docker.com/engine/reference/commandline/start/) Diferentemente do _docker run_, o comanda _docker start_ inicia um _Container_ que esteja parado.
- [__docker stop__](https://docs.docker.com/engine/reference/commandline/stop/) Finaliza um _Container_ que esteja em execução.
- [__docker stop $(docker ps -aq)__](https://docs.docker.com/engine/reference/commandline/ps/) Finaliza todos os containers. A flag __-a__ significa listar todos os Containers (incluindo os que estão parados); e a flag __-q__ exibir apenas os IDs dos Containers.
- [__docker logs__](https://docs.docker.com/engine/reference/commandline/logs/) Utilizado para verificar os logs de um _Container_.
- [__docker exec__](https://docs.docker.com/engine/reference/commandline/exec/) Executa um comando em um _Container_ em execução.

Exemplo de uso:
```
docker exec -it _containerID_ bash
docker exec -it _containerID_ sh
 ```

### Características dos Containers
- _Container_ é apenas um ambiente virtual sendo executado em um host.
- Podemos ter múltiplos _Containers_ sendo executados simultaneamente em um host.
- Quando dizemos host, podemos entender como um Notebook, PC, uma EC2 da AWS ou qualquer ambiente que esteja trabalhando.

## Network
- [__docker network ls__](https://docs.docker.com/engine/reference/commandline/network/) Lista todas as Networks.
- [__docker network create__](https://docs.docker.com/engine/reference/commandline/network_create/) Cria uma Network.

### Características das Networks
- O Docker cria áreas isoladas de Network para que os Containers possam ser executados.
- Quando dois Containers são executados na mesma Network, eles conseguem conversar entre si apenas utilizando o nome do Container.
- Quando Containers são executados fora da Network, eles irão se conectar utilizando _localhost:portNumber_.

![DockerNetwork](https://user-images.githubusercontent.com/29586519/131226825-8bcd41a4-c985-40fb-b710-a0b31126be3b.png)

### Ports
- O host possui algumas portas disponíveis que podem ser abertas para algumas aplicações. Portanto, é necessário realizar o __binding__, ou seja, __vincular a Porta do Host com a Porta do Container__.
- É possível realizar o binding através da flag __-p 8080:80__. O comando anterior deve ser interpretado como _porta do host : porta do container_.
- Não é possível utilizar a mesma Porta do Host mais do que uma vez, porém é possível utilizar o mesmo número de porta para vários _Container_.

![Ports](https://user-images.githubusercontent.com/29586519/131226735-6308110a-42eb-43c0-a463-4bc3387a308a.png)

## Volumes
Docker Volumes são utilizados para a persistência de dados. No ambiente _Host_, nós temos um sistema de dados físico, portando os dados virtuais de um _Container_ são associados a estes dados físicos. Em outras palavras, é uma conexão entre o ambiente físico de dados do _Host_ com o ambiente virtual do _Container_.

 Existem 3 tipos de volumes e todos os tipos são específicados através do comando __docker run__ e a flag __-v__:
1. __Hosts Volumes__: conexão feita entre a pasta física do Host com a pasta virtual do Container.
```
docker run -v /some/content:/usr/share/nginx/html nginx
```

2. __Anonymous Volume__: Não é especificada a pasta física no _Host_, portanto o Docker cria automaticamente uma pasta para cada _Container_.
```
docker run -v /usr/share/nginx/html nginx
```

3. __Named Volumes__: Uma melhoria do tipo _Anonymous Volume_, aqui é especificado o __nome__ do volume criado no _Host_. Neste tipo, é possível referenciar o volume apenas pelo nome, pois não é necessário conhecer o caminho físico.
```
docker run -v nomedovolume:/usr/share/nginx/html nginx
```

## Source
- [Docker Docs](https://docs.docker.com/) 
- [TechWorld with Nana](https://www.youtube.com/watch?v=3c-iBn73dDE)
