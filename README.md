# PokeApiEx

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Ecto

Cria o banco de dados
```bash
mix ecto.create
```

Deleta o banco de dados
```bash
mix ecto.drop
```

Cria uma migration
```bash
mix ecto.gen.migration create_trainer_table
```

Executa as migrations
```bash
mix ecto.migrate
```



## PostGres Docker

```bash
docker run --name postgres-dev -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=poke_api_ex_dev -p 5432:5432 -d postgres
```

```bash
docker start postgres-dev
```

## Phoenix

Inicia o servidor
```bash
mix phx.server
```
