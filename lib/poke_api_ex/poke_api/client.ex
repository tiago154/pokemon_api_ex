defmodule PokeApiEx.PokeApi.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def get_pokemon(name) do
    "/pokemon/#{name}"
    |> get()
    |> handle_get()
  end

  def handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}

  def handle_get({:ok, %Tesla.Env{status: 404}}),
    do: {:error, %{message: "Pokemon not found", status: :not_found}}

  def handle_get({:error, _reason} = error), do: error
end
