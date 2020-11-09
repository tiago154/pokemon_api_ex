defmodule PokeApiEx.Trainer.Pokemon.Create do
  alias PokeApiEx.PokeApi.Client
  alias PokeApiEx.Pokemon
  alias PokeApiEx.Repo
  alias PokeApiEx.Trainer
  alias PokeApiEx.Trainer.Pokemon, as: TrainerPokemon

  def call(%{"name" => name} = params) do
    name
    |> Client.get_pokemon()
    |> handle_response(params)
  end

  defp handle_response({:ok, body}, params) do
    body
    |> Pokemon.build()
    |> create_pokemon(params)
  end

  defp handle_response({:error, _object_error} = error, _params), do: error

  def create_pokemon(
        %Pokemon{
          name: name,
          weight: weight,
          types: types
        },
        %{
          "nickname" => nickname,
          "trainer_id" => trainer_id
        }
      ) do
        params = %{
          name: name,
          weight: weight,
          types: types,
          nickname: nickname,
          trainer_id: trainer_id
        }
        params
        |> TrainerPokemon.build()
        |> handle_build()
  end

  defp handle_build({:ok, pokemon}) do
    case fetch_trainer(pokemon.trainer_id) do
      nil -> {:error, "Trainer not found!"}
      _ -> Repo.insert(pokemon)
    end
  end
  defp handle_build({:error, _changeset} = error), do: error

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
