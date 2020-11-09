defmodule PokeApiExWeb.WelcomeController do
  use PokeApiExWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to the PokeApiEx")
  end
end
