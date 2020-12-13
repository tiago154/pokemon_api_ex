defmodule PokeApiExWeb.TrainersController do
  use PokeApiExWeb, :controller

  action_fallback PokeApiExWeb.FallbackController

  alias PokeApiEx.{Repo, Trainer}
  alias PokeApiExWeb.Auth.Guardian

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def index(conn, _params) do
    trainers = Repo.all(Trainer)

    put_status(conn, :ok)
    |> render("index.json", trainers: trainers)
  end

  def create(conn, params) do
    with {:ok, trainer} <- PokeApiEx.create_trainer(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(trainer) do
      conn
      |> put_status(:created)
      |> render("create.json", %{trainer: trainer, token: token})
    end
  end

  def delete(conn, %{"id" => id}) do
    id
    |> PokeApiEx.delete_trainer()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> PokeApiEx.fetch_trainer()
    |> handle_response(conn, "show.json", :ok)
  end

  def update(conn, params) do
    params
    |> PokeApiEx.update_trainer()
    |> handle_response(conn, "update.json", :ok)
  end

  defp handle_delete({:ok, _trainer}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error, _reason} = error, _conn), do: error

  defp handle_response({:ok, trainer}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer: trainer)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
