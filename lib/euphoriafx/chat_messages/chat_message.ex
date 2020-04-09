defmodule Euphoriafx.ChatMessages.ChatMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_messages" do
    field :message, :string
    field :seen, :boolean, default: false
    field :user_id, :integer

    belongs_to :chat, Euphoriafx.Chats.Chat

    timestamps()
  end

  @doc false
  def changeset(chat_message, attrs) do
    chat_message
    |> cast(attrs, [:message, :seen, :user_id])
    |> validate_required([:message, :seen])
  end
end
