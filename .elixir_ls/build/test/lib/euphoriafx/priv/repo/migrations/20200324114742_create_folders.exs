defmodule Euphoriafx.Repo.Migrations.CreateFolders do
  use Ecto.Migration

  def change do
    create table(:folders) do
      add :name, :string
      add :package_id, references(:packages)
      timestamps()
    end

  end
end
