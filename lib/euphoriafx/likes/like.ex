defmodule Euphoriafx.Likes.Like do
  use Ecto.Schema
  import Ecto.Changeset

  schema "likes" do
    belongs_to :user, Euphoriafx.Accounts.User
    belongs_to :feed, Euphoriafx.Feeds.Feed
    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [])
    |> validate_required([])
  end
end
