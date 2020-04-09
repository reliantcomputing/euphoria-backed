defmodule Euphoriafx.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :text
      add :user_id, references(:users)
      add :feed_id, references(:feeds)

      timestamps()
    end

  end
end
