defmodule PokeApiExWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :Poke_api_ex

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
