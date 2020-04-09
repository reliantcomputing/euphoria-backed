defmodule EuphoriafxWeb.RobotNotificationController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.RobotNotifications
  alias Euphoriafx.RobotNotifications.RobotNotification
  alias Euphoriafx.Accounts
  alias Euphoriafx.Packages

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    robot_notifications = RobotNotifications.list_robot_notifications()
    render(conn, "index.json", robot_notifications: robot_notifications)
  end

  def create(conn, %{"robot_notification" => robot_notification_params}) do

    user = Accounts.get_user!(robot_notification_params["user_id"])
    package = Packages.get_package!(robot_notification_params["package_id"])

    with {:ok, %RobotNotification{} = robot_notification} <- RobotNotifications.create_robot_notification(package, user, robot_notification_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.robot_notification_path(conn, :show, robot_notification))
      |> render("create-show.json", robot_notification: robot_notification)
    end
  end

  def show(conn, %{"id" => id}) do
    robot_notification = RobotNotifications.get_robot_notification!(id)
    render(conn, "show.json", robot_notification: robot_notification)
  end

  def update(conn, %{"id" => id, "robot_notification" => robot_notification_params}) do
    robot_notification = RobotNotifications.get_robot_notification!(id)

    with {:ok, %RobotNotification{} = robot_notification} <- RobotNotifications.update_robot_notification(robot_notification, robot_notification_params) do
      render(conn, "show.json", robot_notification: robot_notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    robot_notification = RobotNotifications.get_robot_notification!(id)

    with {:ok, %RobotNotification{}} <- RobotNotifications.delete_robot_notification(robot_notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
