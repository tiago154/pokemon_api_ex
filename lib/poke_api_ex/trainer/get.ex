defmodule PokeApiEx.Trainer.Get do
  alias Ecto.UUID
  alias PokeApiEx.{Repo, Trainer}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Trainer not found!"}
      trainer -> {:ok, trainer}
    end
  end
end
