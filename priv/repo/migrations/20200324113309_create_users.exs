defmodule Euphoriafx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :image_path, :text, null: true

      add :type_id, references(:types)

      add :package_id, references(:packages), null: true

      timestamps()
    end
  end
end
