defmodule PokeApiExWeb.FallbackController do
  use PokeApiExWeb, :controller

  def call(conn, {:error, %{message: message, status: status}}) do
    conn
    |> put_status(status)
    |> json(%{message: message})
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PokeApiExWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
