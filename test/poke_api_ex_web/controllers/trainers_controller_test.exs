defmodule PokeApiExWeb.TrainersControllerTest do
  use PokeApiExWeb.ConnCase
  import PokeApiExWeb.Auth.Guardian

  alias PokeApiEx.Trainer

  describe "show/2" do
    setup %{conn: conn} do
      params = %{name: "test", password: "123456"}
      {:ok, trainer} = PokeApiEx.create_trainer(params)
      {:ok, token, _claims} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when there is a trainer with the given id, return the trainer", %{conn: conn} do
      params = %{name: "FakeName", password: "123456"}

      {:ok, %Trainer{id: id}} = PokeApiEx.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "inserted_at" => _inserted_at, "name" => "FakeName"} = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "1234"))
        |> json_response(:bad_request)

      expected_response = %{"message" => "invalid ID format!"}

      assert response == expected_response
    end
  end
end
