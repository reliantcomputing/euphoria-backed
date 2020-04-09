defmodule Euphoriafx.OtherNotifications do
  @moduledoc """
  The OtherNotifications context.
  """

  import Ecto.Query, warn: false
  alias Euphoriafx.Repo

  alias Euphoriafx.OtherNotifications.OtherNotification

  @doc """
  Returns the list of other_notifications.

  ## Examples

      iex> list_other_notifications()
      [%OtherNotification{}, ...]

  """
  def list_other_notifications do
    Repo.all(OtherNotification)
    |> Repo.preload([:package, :user])
  end

  @doc """
  Gets a single other_notification.

  Raises `Ecto.NoResultsError` if the Other notification does not exist.

  ## Examples

      iex> get_other_notification!(123)
      %OtherNotification{}

      iex> get_other_notification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_other_notification!(id) do
     Repo.get!(OtherNotification, id)
     |> Repo.preload([:package, :user])
  end

  @doc """
  Creates a other_notification.

  ## Examples

      iex> create_other_notification(%{field: value})
      {:ok, %OtherNotification{}}

      iex> create_other_notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_other_notification(package, user, attrs \\ %{}) do
    %OtherNotification{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:package, package)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> OtherNotification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a other_notification.

  ## Examples

      iex> update_other_notification(other_notification, %{field: new_value})
      {:ok, %OtherNotification{}}

      iex> update_other_notification(other_notification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_other_notification(%OtherNotification{} = other_notification, attrs) do
    other_notification
    |> OtherNotification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a other_notification.

  ## Examples

      iex> delete_other_notification(other_notification)
      {:ok, %OtherNotification{}}

      iex> delete_other_notification(other_notification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_other_notification(%OtherNotification{} = other_notification) do
    Repo.delete(other_notification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking other_notification changes.

  ## Examples

      iex> change_other_notification(other_notification)
      %Ecto.Changeset{source: %OtherNotification{}}

  """
  def change_other_notification(%OtherNotification{} = other_notification) do
    OtherNotification.changeset(other_notification, %{})
  end
end
