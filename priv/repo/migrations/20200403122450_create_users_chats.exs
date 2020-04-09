defmodule Euphoriafx.Repo.Migrations.CreateUsersChats do
  use Ecto.Migration

  def change do
    create table(:users_chats) do
      add :chat_id, references(:chats)
      add :user_id, references(:users)
    end
  end
end
