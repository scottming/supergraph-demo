# Supergraph Demo in Elixir

## Prerequisites

You'll need:

* [apollographql/router](https://github.com/apollographql/router)

## How to run 

Start each of the Elixir federated services in separate terminal windows.

```bash
$ cd <products|users|inventory>
$ mix deps.get
$ mix phx.server
```

Start Router

```bash
$ router -s supergraph.graphql
```


