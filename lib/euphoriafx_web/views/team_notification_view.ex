defmodule EuphoriafxWeb.TeamNotificationView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.TeamNotificationView

  def render("index.json", %{team_notifications: team_notifications}) do
    %{data: render_many(team_notifications, TeamNotificationView, "team_notification.json")}
  end

  def render("show.json", %{team_notification: team_notification}) do
    %{data: render_one(team_notification, TeamNotificationView, "team_notification.json")}
  end

  def render("create-show.json", %{team_notification: team_notification}) do
    %{data: render_one(team_notification, TeamNotificationView, "team_notification.json")}
  end

  def render("team_notification.json", %{team_notification: team_notification}) do
    %{id: team_notification.id,
      notification: team_notification.notification,
      is_viewed: team_notification.is_viewed,
      created_at: team_notification.inserted_at,
      updated_at: team_notification.updated_at}
  end
end
