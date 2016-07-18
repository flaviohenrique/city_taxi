# READ-ME #

## Cidade de Taxis ##

Api Url : <http://city-taxi-env.fas9ph8fd3.us-west-2.elasticbeanstalk.com>

Sistema criado usando Ruby On Rails

Com endpoints para a API REST com as seguintes ações:

 * Mapa
   * [Enviar CSV para criar o Mapa da Cidade](https://bitbucket.org/flaviohenrique85/city_taxi/markdown-header-criar-mapas)
   * [Lista dos mapas criados](#list_map)
   * [Avançar o tempo no mapa](#move_map)
   * [Reiniciar a simulação](#restart_map)
   * [Detalhe da situação atual do mapa](#detail_map)
 * Taxi
   * [Adicionar Taxi no mapa](#create_taxi)
   * [Detalhe do Taxi](#show_taxi)
 * Passageiro
   * [Adicionar Passageiro no mapa](#create_passenger)
   * [Detalhe do Passageiro](#show_passenger)

Com endpoints html para:

  * Avançar o tempo no mapa
  * Reiniciar p tempo no mapa
  * Detalhe da situação atual do mapa

Arquitetura da Aplicação

 * Utilização de rails como MVC
 * Utilização da gem Trail Blazer para separar melhor as camadas da aplicação
  * Separação da validação dos modelos utilizando "Contracts" (Form Objects)
  * Separação das regras de negocio utilizando "Operations" (Service Objects)
  * Separação da serialização de json utilizando "Representers" (Serialializers/Deserializers)
 * Na navegação no Mapa separei em duas camandas:
 	1. Matrix com as linhas e colunas do mapa de acordo com o CSV inicial
 	2. Grafo com as ligações entre as posições onde os taxis e passageiros podem se deslocar. O grafo também serve como base para utlizacão do algoritmo "dijkstra" para busca dos menores caminhos entre os taxis e os passageiros


### End Points ###

### Criar Mapas
#### `POST /api/v1/maps`

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

<a id="list_map"></a>
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

<a id="move_map"></a>
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
<a id="restart_map"></a>
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
<a id="detail_map"></a>
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

<a id="create_taxi"></a>
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

<a id="show_taxi"></a>
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

<a id="create_passenger"></a>
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

<a id="show_passenger"></a>
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