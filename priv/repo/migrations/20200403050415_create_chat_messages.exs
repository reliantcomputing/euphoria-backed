defmodule Euphoriafx.Repo.Migrations.CreateChatMessages do
  use Ecto.Migration

  def change do
    create table(:chat_messages) do
      add :message, :string
      add :seen, :boolean, default: false, null: false
      add :user_id, :integer
      add :chat_id, references(:chats)
      timestamps()
    end
  end
end
