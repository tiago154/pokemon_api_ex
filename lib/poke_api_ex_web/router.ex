defmodule PokeApiExWeb.Router do
  use PokeApiExWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PokeApiExWeb.Auth.Pipeline
  end

  scope "/api", PokeApiExWeb do
    pipe_through :api

    post "/trainers/signin", TrainersController, :sign_in
    post "/trainers", TrainersController, :create
    get "/pokemons/:name", PokemonsController, :show
  end

  scope "/api", PokeApiExWeb do
    pipe_through [:api, :auth]

    resources "/trainers", TrainersController, only: [:index, :show, :delete, :update]
    resources "/trainer_pokemons", TrainerPokemonsController, only: [:index, :create, :show, :delete, :update]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PokeApiExWeb.Telemetry
    end
  end

  scope "/", PokeApiExWeb do
    pipe_through :api

    get "/", WelcomeController, :index
  end
end
