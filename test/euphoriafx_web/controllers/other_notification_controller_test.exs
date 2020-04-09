defmodule EuphoriafxWeb.OtherNotificationControllerTest do
  use EuphoriafxWeb.ConnCase

  alias Euphoriafx.OtherNotifications
  alias Euphoriafx.OtherNotifications.OtherNotification

  @create_attrs %{
    is_viewed: true,
    notification: "some notification"
  }
  @update_attrs %{
    is_viewed: false,
    notification: "some updated notification"
  }
  @invalid_attrs %{is_viewed: nil, notification: nil}

  def fixture(:other_notification) do
    {:ok, other_notification} = OtherNotifications.create_other_notification(@create_attrs)
    other_notification
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all other_notifications", %{conn: conn} do
      conn = get(conn, Routes.other_notification_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create other_notification" do
    test "renders other_notification when data is valid", %{conn: conn} do
      conn = post(conn, Routes.other_notification_path(conn, :create), other_notification: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.other_notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_viewed" => true,
               "notification" => "some notification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.other_notification_path(conn, :create), other_notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update other_notification" do
    setup [:create_other_notification]

    test "renders other_notification when data is valid", %{conn: conn, other_notification: %OtherNotification{id: id} = other_notification} do
      conn = put(conn, Routes.other_notification_path(conn, :update, other_notification), other_notification: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.other_notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_viewed" => false,
               "notification" => "some updated notification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, other_notification: other_notification} do
      conn = put(conn, Routes.other_notification_path(conn, :update, other_notification), other_notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete other_notification" do
    setup [:create_other_notification]

    test "deletes chosen other_notification", %{conn: conn, other_notification: other_notification} do
      conn = delete(conn, Routes.other_notification_path(conn, :delete, other_notification))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.other_notification_path(conn, :show, other_notification))
      end
    end
  end

  defp create_other_notification(_) do
    other_notification = fixture(:other_notification)
    {:ok, other_notification: other_notification}
  end
end
