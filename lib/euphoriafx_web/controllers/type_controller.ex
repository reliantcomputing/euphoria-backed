defmodule EuphoriafxWeb.TypeController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.Accounts
  alias Euphoriafx.Accounts.Type

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    types = Accounts.list_types()
    render(conn, "index.json", types: types)
  end

  def create(conn, %{"type" => type_params}) do
    with {:ok, %Type{} = type} <- Accounts.create_type(type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.type_path(conn, :show, type))
      |> render("create-show.json", type: type)
    end
  end

  def show(conn, %{"id" => id}) do
    type = Accounts.get_type!(id)
    render(conn, "show.json", type: type)
  end

  def update(conn, %{"id" => id, "type" => type_params}) do
    type = Accounts.get_type!(id)

    with {:ok, %Type{} = type} <- Accounts.update_type(type, type_params) do
      render(conn, "show.json", type: type)
    end
  end

  def delete(conn, %{"id" => id}) do
    type = Accounts.get_type!(id)

    with {:ok, %Type{}} <- Accounts.delete_type(type) do
      send_resp(conn, :no_content, "")
    end
  end
end
