defmodule Euphoriafx.TeamNotificationsTest do
  use Euphoriafx.DataCase

  alias Euphoriafx.TeamNotifications

  describe "team_notifications" do
    alias Euphoriafx.TeamNotifications.TeamNotification

    @valid_attrs %{is_viewed: true, notification: "some notification"}
    @update_attrs %{is_viewed: false, notification: "some updated notification"}
    @invalid_attrs %{is_viewed: nil, notification: nil}

    def team_notification_fixture(attrs \\ %{}) do
      {:ok, team_notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TeamNotifications.create_team_notification()

      team_notification
    end

    test "list_team_notifications/0 returns all team_notifications" do
      team_notification = team_notification_fixture()
      assert TeamNotifications.list_team_notifications() == [team_notification]
    end

    test "get_team_notification!/1 returns the team_notification with given id" do
      team_notification = team_notification_fixture()
      assert TeamNotifications.get_team_notification!(team_notification.id) == team_notification
    end

    test "create_team_notification/1 with valid data creates a team_notification" do
      assert {:ok, %TeamNotification{} = team_notification} = TeamNotifications.create_team_notification(@valid_attrs)
      assert team_notification.is_viewed == true
      assert team_notification.notification == "some notification"
    end

    test "create_team_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamNotifications.create_team_notification(@invalid_attrs)
    end

    test "update_team_notification/2 with valid data updates the team_notification" do
      team_notification = team_notification_fixture()
      assert {:ok, %TeamNotification{} = team_notification} = TeamNotifications.update_team_notification(team_notification, @update_attrs)
      assert team_notification.is_viewed == false
      assert team_notification.notification == "some updated notification"
    end

    test "update_team_notification/2 with invalid data returns error changeset" do
      team_notification = team_notification_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamNotifications.update_team_notification(team_notification, @invalid_attrs)
      assert team_notification == TeamNotifications.get_team_notification!(team_notification.id)
    end

    test "delete_team_notification/1 deletes the team_notification" do
      team_notification = team_notification_fixture()
      assert {:ok, %TeamNotification{}} = TeamNotifications.delete_team_notification(team_notification)
      assert_raise Ecto.NoResultsError, fn -> TeamNotifications.get_team_notification!(team_notification.id) end
    end

    test "change_team_notification/1 returns a team_notification changeset" do
      team_notification = team_notification_fixture()
      assert %Ecto.Changeset{} = TeamNotifications.change_team_notification(team_notification)
    end
  end
end
