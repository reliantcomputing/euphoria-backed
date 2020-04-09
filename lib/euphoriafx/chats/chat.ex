defmodule Euphoriafx.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    belongs_to :package, Euphoriafx.Packages.Package
    has_many :messages, Euphoriafx.ChatMessages.ChatMessage
    many_to_many :users, Euphoriafx.Accounts.User, join_through: "users_chats"
    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [])
    |> validate_required([])
  end
end
