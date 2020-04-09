defmodule Euphoriafx.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :content, :string

    field :image_path, :string

    # Parents
    belongs_to :user, Euphoriafx.Accounts.User
    belongs_to :package, Euphoriafx.Packages.Package

    # Children
    has_many :comments, Euphoriafx.Comments.Comment
    has_many :likes, Euphoriafx.Likes.Like

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:content, :image_path])
    |> validate_required([:content])
  end
end
