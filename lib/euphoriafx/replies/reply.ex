defmodule Euphoriafx.Replies.Reply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "replies" do
    field :reply, :string

    belongs_to :user, Euphoriafx.Accounts.User
    belongs_to :comment, Euphoriafx.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(reply, attrs) do
    reply
    |> cast(attrs, [:reply])
    |> validate_required([:reply])
  end
end
