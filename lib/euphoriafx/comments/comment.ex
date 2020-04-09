defmodule Euphoriafx.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :comment, :string

    # Parents
    belongs_to :feed, Euphoriafx.Feeds.Feed
    belongs_to :user, Euphoriafx.Accounts.User

    # Children
    has_many :replies, Euphoriafx.Replies.Reply

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:comment])
    |> validate_required([:comment])
  end
end
