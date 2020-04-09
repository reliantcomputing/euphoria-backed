defmodule EuphoriafxWeb.AuthController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.Accounts
  alias Euphoriafx.Accounts.User
  alias EuphoriafxWeb.Auth.Guardian

  action_fallback EuphoriafxWeb.FallbackController

  def signin(conn, %{"username" => username, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(username, password) do
      conn
      |> put_status(:created)
      |> render("user-token.json", %{user: user, token: token})
    end
  end

  def signup(conn, %{"user" => user_params}) do
    type = Accounts.get_type!(user_params["type_id"])
    with {:ok, %User{} = user} <- Accounts.create_user(type, user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("create-show.json", user: user)
    end
  end

end
