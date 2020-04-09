defmodule Euphoriafx.Videos.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :path, :string

    # Parents
    belongs_to :folder, Euphoriafx.Folders.Folder

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:path])
    |> validate_required([:path])
  end
end
