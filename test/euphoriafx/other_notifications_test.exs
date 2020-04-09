defmodule Euphoriafx.OtherNotificationsTest do
  use Euphoriafx.DataCase

  alias Euphoriafx.OtherNotifications

  describe "other_notifications" do
    alias Euphoriafx.OtherNotifications.OtherNotification

    @valid_attrs %{is_viewed: true, notification: "some notification"}
    @update_attrs %{is_viewed: false, notification: "some updated notification"}
    @invalid_attrs %{is_viewed: nil, notification: nil}

    def other_notification_fixture(attrs \\ %{}) do
      {:ok, other_notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OtherNotifications.create_other_notification()

      other_notification
    end

    test "list_other_notifications/0 returns all other_notifications" do
      other_notification = other_notification_fixture()
      assert OtherNotifications.list_other_notifications() == [other_notification]
    end

    test "get_other_notification!/1 returns the other_notification with given id" do
      other_notification = other_notification_fixture()
      assert OtherNotifications.get_other_notification!(other_notification.id) == other_notification
    end

    test "create_other_notification/1 with valid data creates a other_notification" do
      assert {:ok, %OtherNotification{} = other_notification} = OtherNotifications.create_other_notification(@valid_attrs)
      assert other_notification.is_viewed == true
      assert other_notification.notification == "some notification"
    end

    test "create_other_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OtherNotifications.create_other_notification(@invalid_attrs)
    end

    test "update_other_notification/2 with valid data updates the other_notification" do
      other_notification = other_notification_fixture()
      assert {:ok, %OtherNotification{} = other_notification} = OtherNotifications.update_other_notification(other_notification, @update_attrs)
      assert other_notification.is_viewed == false
      assert other_notification.notification == "some updated notification"
    end

    test "update_other_notification/2 with invalid data returns error changeset" do
      other_notification = other_notification_fixture()
      assert {:error, %Ecto.Changeset{}} = OtherNotifications.update_other_notification(other_notification, @invalid_attrs)
      assert other_notification == OtherNotifications.get_other_notification!(other_notification.id)
    end

    test "delete_other_notification/1 deletes the other_notification" do
      other_notification = other_notification_fixture()
      assert {:ok, %OtherNotification{}} = OtherNotifications.delete_other_notification(other_notification)
      assert_raise Ecto.NoResultsError, fn -> OtherNotifications.get_other_notification!(other_notification.id) end
    end

    test "change_other_notification/1 returns a other_notification changeset" do
      other_notification = other_notification_fixture()
      assert %Ecto.Changeset{} = OtherNotifications.change_other_notification(other_notification)
    end
  end
end
