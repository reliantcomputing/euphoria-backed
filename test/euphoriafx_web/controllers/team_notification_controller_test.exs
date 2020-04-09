defmodule EuphoriafxWeb.TeamNotificationControllerTest do
  use EuphoriafxWeb.ConnCase

  alias Euphoriafx.TeamNotifications
  alias Euphoriafx.TeamNotifications.TeamNotification

  @create_attrs %{
    is_viewed: true,
    notification: "some notification"
  }
  @update_attrs %{
    is_viewed: false,
    notification: "some updated notification"
  }
  @invalid_attrs %{is_viewed: nil, notification: nil}

  def fixture(:team_notification) do
    {:ok, team_notification} = TeamNotifications.create_team_notification(@create_attrs)
    team_notification
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all team_notifications", %{conn: conn} do
      conn = get(conn, Routes.team_notification_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create team_notification" do
    test "renders team_notification when data is valid", %{conn: conn} do
      conn = post(conn, Routes.team_notification_path(conn, :create), team_notification: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.team_notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_viewed" => true,
               "notification" => "some notification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.team_notification_path(conn, :create), team_notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update team_notification" do
    setup [:create_team_notification]

    test "renders team_notification when data is valid", %{conn: conn, team_notification: %TeamNotification{id: id} = team_notification} do
      conn = put(conn, Routes.team_notification_path(conn, :update, team_notification), team_notification: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.team_notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_viewed" => false,
               "notification" => "some updated notification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, team_notification: team_notification} do
      conn = put(conn, Routes.team_notification_path(conn, :update, team_notification), team_notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete team_notification" do
    setup [:create_team_notification]

    test "deletes chosen team_notification", %{conn: conn, team_notification: team_notification} do
      conn = delete(conn, Routes.team_notification_path(conn, :delete, team_notification))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.team_notification_path(conn, :show, team_notification))
      end
    end
  end

  defp create_team_notification(_) do
    team_notification = fixture(:team_notification)
    {:ok, team_notification: team_notification}
  end
end
