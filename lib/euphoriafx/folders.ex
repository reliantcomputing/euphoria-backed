defmodule Euphoriafx.Folders do
  @moduledoc """
  The Folders context.
  """

  import Ecto.Query, warn: false
  alias Euphoriafx.Repo

  alias Euphoriafx.Folders.Folder

  @doc """
  Returns the list of folders.

  ## Examples

      iex> list_folders()
      [%Folder{}, ...]

  """
  def list_folders do
    Repo.all(Folder)
    |> Repo.preload([:package, :videos])
  end

  @doc """
  Gets a single folder.

  Raises `Ecto.NoResultsError` if the Folder does not exist.

  ## Examples

      iex> get_folder!(123)
      %Folder{}

      iex> get_folder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_folder!(id), do: Repo.get!(Folder, id) |> Repo.preload([:package, :videos])

  @doc """
  Creates a folder.

  ## Examples

      iex> create_folder(%{field: value})
      {:ok, %Folder{}}

      iex> create_folder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_folder(package, attrs \\ %{}) do
    %Folder{}
    |> Folder.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:package, package)
    |> Repo.insert()
  end

  @doc """
  Updates a folder.

  ## Examples

      iex> update_folder(folder, %{field: new_value})
      {:ok, %Folder{}}

      iex> update_folder(folder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_folder(%Folder{} = folder, attrs) do
    folder
    |> Folder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a folder.

  ## Examples

      iex> delete_folder(folder)
      {:ok, %Folder{}}

      iex> delete_folder(folder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_folder(%Folder{} = folder) do
    Repo.delete(folder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking folder changes.

  ## Examples

      iex> change_folder(folder)
      %Ecto.Changeset{source: %Folder{}}

  """
  def change_folder(%Folder{} = folder) do
    Folder.changeset(folder, %{})
  end
end
