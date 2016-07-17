# READ-ME #

## Cidade de Taxis ###

Api Url : <http://city-taxi-env.fas9ph8fd3.us-west-2.elasticbeanstalk.com>

Sistema criado usando Ruby On Rails

Com endpoints para a API REST com as seguintes ações:

 * Mapa
  * [Enviar CSV para criar o Mapa da Cidade](#create_map)
  * [Lista dos mapas criados](#list_map)
  * Avançar o tempo no mapa
  * Reiniciar p tempo no mapa
  * Detalhe da situação atual do mapa
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


### End Points ###

<a id="create_map"></a>
### `POST /api/v1/maps`

Por causa de ter upload de arquivos usei como padrão **multipart/form-data**

```form
name
file
```

#### response

> Success (Status: **201**) com resposta em **application/json**

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


