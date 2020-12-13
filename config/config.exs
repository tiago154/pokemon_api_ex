# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :Poke_api_ex,
  ecto_repos: [PokeApiEx.Repo]

# Configures the endpoint
config :Poke_api_ex, PokeApiExWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CtANMkyccH6zjmaxVo1PWpaQlM8Yynqe+/31L6D6o99gDhWGSiMJyohtyLp1vLGD",
  render_errors: [view: PokeApiExWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PokeApiEx.PubSub,
  live_view: [signing_salt: "rR2EnAk1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :Poke_api_ex, PokeApiExWeb.Auth.Guardian,
  issuer: "Poke_api_ex",
  secret_key: "LLvUqG6FOOG3wid8GO1wVW6OcPqjKYDT3xLwgFSinLj4CSku2qEJiYkqZTkV9K/j"

config :Poke_api_ex, PokeApiExWeb.Auth.Pipeline,
  module: PokeApiExWeb.Auth.Guardian,
  error_handler: PokeApiExWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
