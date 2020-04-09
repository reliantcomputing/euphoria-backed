defmodule Euphoriafx.Folders.Folder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "folders" do
    field :name, :string

    # Parents
    belongs_to :package, Euphoriafx.Packages.Package

    # Children
    has_many :videos, Euphoriafx.Videos.Video

    timestamps()
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
