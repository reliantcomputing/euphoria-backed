defmodule Euphoriafx.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :path, :text

      timestamps()
    end

  end
end
