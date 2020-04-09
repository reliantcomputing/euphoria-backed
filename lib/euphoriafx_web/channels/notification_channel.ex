defmodule EuphoriafxWeb.NotificationChannel do
  use EuphoriafxWeb, :channel

  alias Euphoriafx.OtherNotifications
  alias Euphoriafx.Packages
  alias Euphoriafx.Accounts
  alias Euphoriafx.OtherNotifications.OtherNotification
  alias Euphoriafx.TeamNotifications
  alias Euphoriafx.RobotNotifications


  def join("notifications:robot:"  <> package_id, payload, socket) do
    if authorized?(payload) do
      {:ok, assign(socket, :package_id, String.to_integer(package_id))}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("notifications:team:"  <> package_id, payload, socket) do
    IO.inspect("Package id is here: " <> package_id)
    if authorized?(payload) do
      {:ok, assign(socket, :package_id, String.to_integer(package_id))}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("notifications:other:"  <> package_id, payload, socket) do
    IO.inspect("Package id is here: " <> package_id)
    if authorized?(payload) do
      {:ok, assign(socket, :package_id, String.to_integer(package_id))}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Handle response
  def handle_in("new_robot_notification", payload, socket) do

    IO.inspect(payload["robot_notification"])

    notification = payload["robot_notification"]
    package = Packages.get_package!(notification["package_id"])
    user = Accounts.get_user!(notification["user_id"])

    RobotNotifications.create_robot_notification(package, user, notification)

    broadcast!(socket, "new_robot_notification", %{
      "robot_notifcation": payload["robot_notification"]
      })
    {:reply, :ok, socket}
  end

  def handle_in("new_team_notification", payload, socket) do

    notification = payload["team_notification"]
    package = Packages.get_package!(notification["package_id"])
    user = Accounts.get_user!(notification["user_id"])

    TeamNotifications.create_team_notification(package, user, notification)

    broadcast!(socket, "new_team_notification", %{
      "team_notification": payload["team_notification"]
      })
    {:reply, :ok, socket}
  end

  def handle_in("new_other_notification", payload, socket) do
    notification = payload["other_notification"]
    package = Packages.get_package!(notification["package_id"])
    user = Accounts.get_user!(notification["user_id"])

    OtherNotifications.create_other_notification(package, user, notification)

    broadcast!(socket, "new_other_notification", %{
      "other_notification": payload["other_notification"]
      })
    {:reply, :ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (notification:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
