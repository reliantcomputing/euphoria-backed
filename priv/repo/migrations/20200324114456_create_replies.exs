defmodule Euphoriafx.Repo.Migrations.CreateReplies do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :reply, :text
      add :comment_id, references(:comments)
      add :user_id, references(:users)

      timestamps()
    end

  end
end
