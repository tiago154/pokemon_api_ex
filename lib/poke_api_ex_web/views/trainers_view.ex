defmodule PokeApiExWeb.TrainersView do
  use PokeApiExWeb, :view
  alias PokeApiEx.Trainer
  alias PokeApiExWeb.TrainersView

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end

  def render("index.json", %{trainers: trainers}) do
    %{
      data:
        render_many(
          trainers,
          TrainersView,
          "trainer.json",
          as: :trainer
        )
    }
  end

  def render("show.json", %{trainer: trainer}) do
    render_one(trainer, TrainersView, "trainer.json", as: :trainer)
  end

  def render("update.json", %{
        trainer: %Trainer{
          id: id,
          name: name,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      message: "Trainer updated!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("create.json", %{
        trainer: %Trainer{
          id: id,
          name: name,
          inserted_at: inserted_at
        },
        token: token
      }) do
    %{
      message: "Trainer created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  def render("trainer.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      id: id,
      name: name,
      inserted_at: inserted_at
    }
  end
end
