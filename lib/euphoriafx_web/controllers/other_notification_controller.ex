defmodule EuphoriafxWeb.OtherNotificationController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.OtherNotifications
  alias Euphoriafx.OtherNotifications.OtherNotification
  alias Euphoriafx.Accounts
  alias Euphoriafx.Packages

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    other_notifications = OtherNotifications.list_other_notifications()
    render(conn, "index.json", other_notifications: other_notifications)
  end

  def create(conn, %{"other_notification" => other_notification_params}) do
    user = Accounts.get_user!(other_notification_params["user_id"])
    package = Packages.get_package!(other_notification_params["package_id"])
    with {:ok, %OtherNotification{} = other_notification} <- OtherNotifications.create_other_notification(package, user, other_notification_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.other_notification_path(conn, :show, other_notification))
      |> render("create-show.json", other_notification: other_notification)
    end
  end

  def show(conn, %{"id" => id}) do
    other_notification = OtherNotifications.get_other_notification!(id)
    render(conn, "show.json", other_notification: other_notification)
  end

  def update(conn, %{"id" => id, "other_notification" => other_notification_params}) do
    other_notification = OtherNotifications.get_other_notification!(id)

    with {:ok, %OtherNotification{} = other_notification} <- OtherNotifications.update_other_notification(other_notification, other_notification_params) do
      render(conn, "show.json", other_notification: other_notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    other_notification = OtherNotifications.get_other_notification!(id)

    with {:ok, %OtherNotification{}} <- OtherNotifications.delete_other_notification(other_notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
