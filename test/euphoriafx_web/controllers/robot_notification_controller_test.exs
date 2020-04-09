defmodule EuphoriafxWeb.RobotNotificationControllerTest do
  use EuphoriafxWeb.ConnCase

  alias Euphoriafx.RobotNotifications
  alias Euphoriafx.RobotNotifications.RobotNotification

  @create_attrs %{
    is_viewed: true,
    notification: "some notification"
  }
  @update_attrs %{
    is_viewed: false,
    notification: "some updated notification"
  }
  @invalid_attrs %{is_viewed: nil, notification: nil}

  def fixture(:robot_notification) do
    {:ok, robot_notification} = RobotNotifications.create_robot_notification(@create_attrs)
    robot_notification
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all robot_notifications", %{conn: conn} do
      conn = get(conn, Routes.robot_notification_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create robot_notification" do
    test "renders robot_notification when data is valid", %{conn: conn} do
      conn = post(conn, Routes.robot_notification_path(conn, :create), robot_notification: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.robot_notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_viewed" => true,
               "notification" => "some notification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.robot_notification_path(conn, :create), robot_notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update robot_notification" do
    setup [:create_robot_notification]

    test "renders robot_notification when data is valid", %{conn: conn, robot_notification: %RobotNotification{id: id} = robot_notification} do
      conn = put(conn, Routes.robot_notification_path(conn, :update, robot_notification), robot_notification: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.robot_notification_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_viewed" => false,
               "notification" => "some updated notification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, robot_notification: robot_notification} do
      conn = put(conn, Routes.robot_notification_path(conn, :update, robot_notification), robot_notification: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete robot_notification" do
    setup [:create_robot_notification]

    test "deletes chosen robot_notification", %{conn: conn, robot_notification: robot_notification} do
      conn = delete(conn, Routes.robot_notification_path(conn, :delete, robot_notification))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.robot_notification_path(conn, :show, robot_notification))
      end
    end
  end

  defp create_robot_notification(_) do
    robot_notification = fixture(:robot_notification)
    {:ok, robot_notification: robot_notification}
  end
end
