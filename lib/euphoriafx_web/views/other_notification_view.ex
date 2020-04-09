defmodule EuphoriafxWeb.OtherNotificationView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.OtherNotificationView

  def render("index.json", %{other_notifications: other_notifications}) do
    %{data: render_many(other_notifications, OtherNotificationView, "other_notification.json")}
  end

  def render("show.json", %{other_notification: other_notification}) do
    %{data: render_one(other_notification, OtherNotificationView, "other_notification.json")}
  end

  def render("create-show.json", %{other_notification: other_notification}) do
    %{data: render_one(other_notification, OtherNotificationView, "other_notification.json")}
  end

  def render("other_notification.json", %{other_notification: other_notification}) do
    %{id: other_notification.id,
      notification: other_notification.notification,
      is_viewed: other_notification.is_viewed,
      created_at: other_notification.inserted_at,
      updated_at: other_notification.updated_at}
  end
end
