defmodule EuphoriafxWeb.UserPackageControllerTest do
  use EuphoriafxWeb.ConnCase

  alias Euphoriafx.UserPackages
  alias Euphoriafx.UserPackages.UserPackage

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:user_package) do
    {:ok, user_package} = UserPackages.create_user_package(@create_attrs)
    user_package
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users_packages", %{conn: conn} do
      conn = get(conn, Routes.user_package_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_package" do
    test "renders user_package when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_package_path(conn, :create), user_package: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_package_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_package_path(conn, :create), user_package: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_package" do
    setup [:create_user_package]

    test "renders user_package when data is valid", %{conn: conn, user_package: %UserPackage{id: id} = user_package} do
      conn = put(conn, Routes.user_package_path(conn, :update, user_package), user_package: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_package_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_package: user_package} do
      conn = put(conn, Routes.user_package_path(conn, :update, user_package), user_package: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_package" do
    setup [:create_user_package]

    test "deletes chosen user_package", %{conn: conn, user_package: user_package} do
      conn = delete(conn, Routes.user_package_path(conn, :delete, user_package))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_package_path(conn, :show, user_package))
      end
    end
  end

  defp create_user_package(_) do
    user_package = fixture(:user_package)
    {:ok, user_package: user_package}
  end
end
