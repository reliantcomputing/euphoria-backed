defmodule Euphoriafx.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :path, :string

    # Parents
    belongs_to :feed, Euphoriafx.Feeds.Feed

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:path])
    |> validate_required([:path])
  end
end
