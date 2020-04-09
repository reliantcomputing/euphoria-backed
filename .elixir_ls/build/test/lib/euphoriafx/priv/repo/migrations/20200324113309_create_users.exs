defmodule Euphoriafx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_hash, :string

      add :type_id, references(:types)

      add :package_id, references(:packages), null: true

      timestamps()
    end
  end
end
