defmodule Euphoriafx.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :content, :string

      add :user_id, references(:users)

      add :package_id, references(:packages)

      timestamps()
    end

  end
end
