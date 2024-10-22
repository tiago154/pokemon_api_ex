defmodule PokeApiEx.Pokemon.Get do
  alias PokeApiEx.PokeApi.Client
  alias PokeApiEx.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon()
    |> handle_response()
  end

  defp handle_response({:ok, body}), do: {:ok, Pokemon.build(body)}
  defp handle_response({:error, _reason} = error), do: error
end
