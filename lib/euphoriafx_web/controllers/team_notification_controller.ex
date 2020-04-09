defmodule EuphoriafxWeb.TeamNotificationController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.TeamNotifications
  alias Euphoriafx.TeamNotifications.TeamNotification
  alias Euphoriafx.Accounts
  alias Euphoriafx.Packages

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    team_notifications = TeamNotifications.list_team_notifications()
    render(conn, "index.json", team_notifications: team_notifications)
  end

  def create(conn, %{"team_notification" => team_notification_params}) do
    user = Accounts.get_user!(team_notification_params["user_id"])
    package = Packages.get_package!(team_notification_params["package_id"])
    with {:ok, %TeamNotification{} = team_notification} <- TeamNotifications.create_team_notification(package, user, team_notification_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_notification_path(conn, :show, team_notification))
      |> render("create-show.json", team_notification: team_notification)
    end
  end

  def show(conn, %{"id" => id}) do
    team_notification = TeamNotifications.get_team_notification!(id)
    render(conn, "show.json", team_notification: team_notification)
  end

  def update(conn, %{"id" => id, "team_notification" => team_notification_params}) do
    team_notification = TeamNotifications.get_team_notification!(id)

    with {:ok, %TeamNotification{} = team_notification} <- TeamNotifications.update_team_notification(team_notification, team_notification_params) do
      render(conn, "show.json", team_notification: team_notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    team_notification = TeamNotifications.get_team_notification!(id)

    with {:ok, %TeamNotification{}} <- TeamNotifications.delete_team_notification(team_notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
