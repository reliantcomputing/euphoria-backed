defmodule Euphoriafx.TeamNotifications do
  @moduledoc """
  The TeamNotifications context.
  """

  import Ecto.Query, warn: false
  alias Euphoriafx.Repo

  alias Euphoriafx.TeamNotifications.TeamNotification

  @doc """
  Returns the list of team_notifications.

  ## Examples

      iex> list_team_notifications()
      [%TeamNotification{}, ...]

  """
  def list_team_notifications do
    Repo.all(TeamNotification)
    |> Repo.preload([:package])
  end

  @doc """
  Gets a single team_notification.

  Raises `Ecto.NoResultsError` if the Team notification does not exist.

  ## Examples

      iex> get_team_notification!(123)
      %TeamNotification{}

      iex> get_team_notification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team_notification!(id) do
     Repo.get!(TeamNotification, id)
     |> Repo.preload([:package, :user])
  end

  @doc """
  Creates a team_notification.

  ## Examples

      iex> create_team_notification(%{field: value})
      {:ok, %TeamNotification{}}

      iex> create_team_notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team_notification(package, user, attrs \\ %{}) do
    %TeamNotification{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:package, package)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> TeamNotification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team_notification.

  ## Examples

      iex> update_team_notification(team_notification, %{field: new_value})
      {:ok, %TeamNotification{}}

      iex> update_team_notification(team_notification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team_notification(%TeamNotification{} = team_notification, attrs) do
    team_notification
    |> TeamNotification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team_notification.

  ## Examples

      iex> delete_team_notification(team_notification)
      {:ok, %TeamNotification{}}

      iex> delete_team_notification(team_notification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team_notification(%TeamNotification{} = team_notification) do
    Repo.delete(team_notification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team_notification changes.

  ## Examples

      iex> change_team_notification(team_notification)
      %Ecto.Changeset{source: %TeamNotification{}}

  """
  def change_team_notification(%TeamNotification{} = team_notification) do
    TeamNotification.changeset(team_notification, %{})
  end
end
