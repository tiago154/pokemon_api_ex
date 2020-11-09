defmodule PokeApiEx.Repo do
  use Ecto.Repo,
    otp_app: :Poke_api_ex,
    adapter: Ecto.Adapters.Postgres
end
