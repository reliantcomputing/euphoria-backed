defmodule Euphoriafx.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :package_id, references(:packages)
      timestamps()
    end
  end
end
