defmodule Euphoriafx.RobotNotificationsTest do
  use Euphoriafx.DataCase

  alias Euphoriafx.RobotNotifications

  describe "robot_notifications" do
    alias Euphoriafx.RobotNotifications.RobotNotification

    @valid_attrs %{is_viewed: true, notification: "some notification"}
    @update_attrs %{is_viewed: false, notification: "some updated notification"}
    @invalid_attrs %{is_viewed: nil, notification: nil}

    def robot_notification_fixture(attrs \\ %{}) do
      {:ok, robot_notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RobotNotifications.create_robot_notification()

      robot_notification
    end

    test "list_robot_notifications/0 returns all robot_notifications" do
      robot_notification = robot_notification_fixture()
      assert RobotNotifications.list_robot_notifications() == [robot_notification]
    end

    test "get_robot_notification!/1 returns the robot_notification with given id" do
      robot_notification = robot_notification_fixture()
      assert RobotNotifications.get_robot_notification!(robot_notification.id) == robot_notification
    end

    test "create_robot_notification/1 with valid data creates a robot_notification" do
      assert {:ok, %RobotNotification{} = robot_notification} = RobotNotifications.create_robot_notification(@valid_attrs)
      assert robot_notification.is_viewed == true
      assert robot_notification.notification == "some notification"
    end

    test "create_robot_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RobotNotifications.create_robot_notification(@invalid_attrs)
    end

    test "update_robot_notification/2 with valid data updates the robot_notification" do
      robot_notification = robot_notification_fixture()
      assert {:ok, %RobotNotification{} = robot_notification} = RobotNotifications.update_robot_notification(robot_notification, @update_attrs)
      assert robot_notification.is_viewed == false
      assert robot_notification.notification == "some updated notification"
    end

    test "update_robot_notification/2 with invalid data returns error changeset" do
      robot_notification = robot_notification_fixture()
      assert {:error, %Ecto.Changeset{}} = RobotNotifications.update_robot_notification(robot_notification, @invalid_attrs)
      assert robot_notification == RobotNotifications.get_robot_notification!(robot_notification.id)
    end

    test "delete_robot_notification/1 deletes the robot_notification" do
      robot_notification = robot_notification_fixture()
      assert {:ok, %RobotNotification{}} = RobotNotifications.delete_robot_notification(robot_notification)
      assert_raise Ecto.NoResultsError, fn -> RobotNotifications.get_robot_notification!(robot_notification.id) end
    end

    test "change_robot_notification/1 returns a robot_notification changeset" do
      robot_notification = robot_notification_fixture()
      assert %Ecto.Changeset{} = RobotNotifications.change_robot_notification(robot_notification)
    end
  end
end
