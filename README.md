# README

## Como executar:
  - Instalação do Docker
  - Iniciando a Aplicação
  - Configuração da base de dados

## Instalação do Docker
Antes de tudo, precisamos instalar o docker e o docker-compose

- [Mac](https://docs.docker.com/docker-for-mac/install/)
- [Windows](https://docs.docker.com/docker-for-windows/install/)

- Linux
  - [CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
  - [Debian](https://docs.docker.com/install/linux/docker-ce/debian/)
  - [Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)
  - [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
  - [Binaries](https://docs.docker.com/install/linux/docker-ce/binaries/)
  - [Depois de instalar](https://docs.docker.com/install/linux/linux-postinstall/)


## Iniciando a Aplicação
Rode o commando abaixo para iniciar a aplicação
```sh
docker-compose up -d
```

Assim que a instalação for concluída, verifique se os containers estão rodando corretamente
```sh
docker ps
```

```sh
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                                       NAMES
59d4b9e90e9a   rover-rover           "entrypoint.sh bash …"   52 seconds ago   Up 18 seconds   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   rover
f4b30a57b9d3   postgres:9.6-alpine   "docker-entrypoint.s…"   52 seconds ago   Up 18 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   rover_database
```

### Crie a base de dados

```sh
docker exec -it rover bundle exec rails db:create
```

### Acesse o endereço
- [http://localhost:3000/](http://localhost:3000/)


# Observações

## Considerei que o rover não pode sair do platoau e também não pode ir para uma posição que já exista outro rover (não ocorre conflito), assim o comando é "descartado" e a execução continua com o próximo comando.

Assim:
```ruby
5 5
2 3 N
M
2 5 S
MRM
```

retorna:
```ruby
2 4 N
1 5 W
```

## Temos casos de testes na pasta "testes"
