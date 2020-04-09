defmodule Euphoriafx.Repo.Migrations.CreateUsersPackages do
  use Ecto.Migration

  def change do
    create table(:users_packages) do

      timestamps()
    end

  end
end
