defmodule EuphoriafxWeb.RobotNotificationView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.RobotNotificationView

  def render("index.json", %{robot_notifications: robot_notifications}) do
    %{data: render_many(robot_notifications, RobotNotificationView, "robot_notification.json")}
  end

  def render("show.json", %{robot_notification: robot_notification}) do
    %{data: render_one(robot_notification, RobotNotificationView, "robot_notification.json")}
  end

  def render("create-show.json", %{robot_notification: robot_notification}) do
    %{data: render_one(robot_notification, RobotNotificationView, "robot_notification.json")}
  end

  def render("robot_notification.json", %{robot_notification: robot_notification}) do
    %{id: robot_notification.id,
      notification: robot_notification.notification,
      is_viewed: robot_notification.is_viewed,
      created_at: robot_notification.inserted_at,
      updated_at: robot_notification.updated_at}
  end
end
