# Cidade de Taxis #

Api Url : <http://city-taxi-env.fas9ph8fd3.us-west-2.elasticbeanstalk.com>

Sistema criado usando Ruby On Rails

Com endpoints para a API REST com as seguintes ações:

 * Mapa
   * [Enviar CSV para criar o Mapa da Cidade](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-criar-mapas)
   * [Lista dos mapas criados](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-listar-mapas)
   * [Avançar o tempo no mapa](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-avancar-tempo)
   * [Reiniciar a simulação](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-reiniciar)
   * [Detalhe da situação atual do mapa](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-detalhe-mapa)
 * Taxi
   * [Adicionar Taxi no mapa](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-adicionar-taxi)
   * [Detalhe do Taxi](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-exibir-taxi)
 * Passageiro
   * [Adicionar Passageiro no mapa](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-adicionar-passageiro)
   * [Detalhe do Passageiro](https://bitbucket.org/flaviohenrique85/city_taxi#markdown-header-exibir-passageiro)

Com endpoints html para:

  * Avançar o tempo no mapa
  * Reiniciar p tempo no mapa
  * Detalhe da situação atual do mapa [/maps/:id.html](http://city-taxi-env.fas9ph8fd3.us-west-2.elasticbeanstalk.com/maps/1.html)

Arquitetura da Aplicação

 * Utilização de rails como MVC
 * Utilização da gem Trail Blazer para separar melhor as camadas da aplicação
  * Separação da validação dos modelos utilizando "Contracts" (Form Objects)
  * Separação das regras de negocio utilizando "Operations" (Service Objects)
  * Separação da serialização de json utilizando "Representers" (Serialializers/Deserializers)
 * Na navegação no Mapa separei em duas camandas:
 	1. Matrix com as linhas e colunas do mapa de acordo com o CSV inicial
 	2. Grafo com as ligações entre as posições onde os taxis e passageiros podem se deslocar. O grafo também serve como base para utlizacão do algoritmo "dijkstra" para busca dos menores caminhos entre os taxis e os passageiros


## End Points ##

### Criar Mapas
### `POST /api/v1/maps`

Por causa de ter upload de arquivos usei como padrão **multipart/form-data**

```form
name
file
```

#### response

> Created (Status: **201**) com resposta em **application/json**

```json
{
  "id": 7,
  "name": "Cidade 10",
  "time": 0
}
```

### Listar Mapas
### `GET /api/v1/maps.json`
#### response

> Success (Status: **200**) com resposta em **application/json**

```json
[
  {
    "id": 2,
    "name": "Cidade 2",
    "time": 1
  },
  {
    "id": 3,
    "name": "Cidade 3",
    "time": 0
  }
]
```

### Avançar Tempo
### `PUT /api/v1/maps/:id/move.json`
#### request

```json
Vazio
```

#### response

> Success (Status: **200**)

```json
{
  "id": 1,
  "name": "Cidade 1",
  "time": 1,
  "rows": 30,
  "cols": 30,
  "area": [
  	[
      {
        "row": 0,
        "col": 0,
        "blocked": false,
        "taxis": [
          {
            "name": "Joao 1",
            "status": "full"
          }
        ],
        "passengers": [
          {
            "name": "Joao Passenger",
            "status": "going"
          }
        ]
      },
      ...
   ],
   ...
  ]
}

```
### Reiniciar
### `PUT /api/v1/maps/:id/restart.json`
#### request

```json
Vazio
```

#### response

> Success (Status: **200**)

```json
{
  "id": 1,
  "name": "Cidade 1",
  "time": 0,
  "rows": 30,
  "cols": 30,
  "area": [
  	[
      {
        "row": 0,
        "col": 0,
        "blocked": false,
        "taxis": [],
        "passengers": []
      },
      ...
   ],
   ...
  ]
}
```
### Detalhe Mapa
### `GET /api/v1/maps/:id/detail.json`
#### request

```json
Vazio
```

#### response

> Success (Status: **200**)

```json
{
  "id": 1,
  "name": "Cidade 1",
  "time": 1,
  "rows": 30,
  "cols": 30,  
  "area": [
  	[
      {
        "row": 0,
        "col": 0,
        "blocked": false,
        "taxis": [
          {
            "name": "Joao 1",
            "status": "full"
          }
        ],
        "passengers": [
          {
            "name": "Joao Passenger",
            "status": "going"
          }
        ]
      },
      ...
   ],
   ...
  ]
}
```

### Adicionar Taxi
### `POST /api/v1/taxis.json`
#### request

```json
{
    "name" : "Joao 1",
    "row" : 0,
    "col" : 0,
    "map_id" : 1
}
```

#### response

> Created (Status: **201**)

```json
{
  "id": 4,
  "name": "Joao 1",
  "row": 0,
  "col": 0,
  "map_id": 1,
  "status": "empty"
}
```

### Exibir Taxi
### `GET /api/v1/taxis/:id.json`
#### response

> Success (Status: **200**)

```json
{
  "id": 4,
  "name": "Joao 1",
  "row": 0,
  "col": 0,
  "map_id": 1,
  "status": "empty"
}
```

### Adicionar Passageiro
### `POST /api/v1/passengers.json`
#### request

```json
{
  "name" : "Joao 2",
  "row" : 0,
  "col" : 0,
  "dest_row" : 20,
  "dest_col" : 20,
  "map_id" : 1
}
```

#### response

> Created (Status: **201**)

```json
{
  "id": 2,
  "name": "Joao 2",
  "row": 0,
  "col": 0,
  "dest_row": 20,
  "dest_col": 20,
  "map_id": 1
}
```

### Exibir Passageiro
### `GET /api/v1/passengers/:id.json`
#### response

> Success (Status: **200**)

```json
{
  "id": 1,
  "name": "Joao Passenger",
  "row": 0,
  "col": 0,
  "dest_row": 20,
  "dest_col": 20,
  "map_id": 1
}
```