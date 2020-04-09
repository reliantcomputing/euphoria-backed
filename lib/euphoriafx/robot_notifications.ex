defmodule Euphoriafx.RobotNotifications do
  @moduledoc """
  The RobotNotifications context.
  """

  import Ecto.Query, warn: false
  alias Euphoriafx.Repo

  alias Euphoriafx.RobotNotifications.RobotNotification

  @doc """
  Returns the list of robot_notifications.

  ## Examples

      iex> list_robot_notifications()
      [%RobotNotification{}, ...]

  """
  def list_robot_notifications do
    Repo.all(RobotNotification)
    |> Repo.preload([:package, :user])
  end

  @doc """
  Gets a single robot_notification.

  Raises `Ecto.NoResultsError` if the Robot notification does not exist.

  ## Examples

      iex> get_robot_notification!(123)
      %RobotNotification{}

      iex> get_robot_notification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_robot_notification!(id) do
    Repo.get!(RobotNotification, id)
    |> Repo.preload([:package, :user])
  end

  @doc """
  Creates a robot_notification.

  ## Examples

      iex> create_robot_notification(%{field: value})
      {:ok, %RobotNotification{}}

      iex> create_robot_notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_robot_notification(package, user, attrs \\ %{}) do
    %RobotNotification{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:package, package)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> RobotNotification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a robot_notification.

  ## Examples

      iex> update_robot_notification(robot_notification, %{field: new_value})
      {:ok, %RobotNotification{}}

      iex> update_robot_notification(robot_notification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_robot_notification(%RobotNotification{} = robot_notification, attrs) do
    robot_notification
    |> RobotNotification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a robot_notification.

  ## Examples

      iex> delete_robot_notification(robot_notification)
      {:ok, %RobotNotification{}}

      iex> delete_robot_notification(robot_notification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_robot_notification(%RobotNotification{} = robot_notification) do
    Repo.delete(robot_notification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking robot_notification changes.

  ## Examples

      iex> change_robot_notification(robot_notification)
      %Ecto.Changeset{source: %RobotNotification{}}

  """
  def change_robot_notification(%RobotNotification{} = robot_notification) do
    RobotNotification.changeset(robot_notification, %{})
  end
end
