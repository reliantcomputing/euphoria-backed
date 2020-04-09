defmodule Euphoriafx.Repo.Migrations.CreatePackages do
  use Ecto.Migration

  def change do
    create table(:packages) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
