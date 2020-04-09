defmodule Euphoriafx.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      
      add :content, :text

      add :image_path, :text, null: true

      add :user_id, references(:users)

      add :package_id, references(:packages)

      timestamps()
    end

  end
end
