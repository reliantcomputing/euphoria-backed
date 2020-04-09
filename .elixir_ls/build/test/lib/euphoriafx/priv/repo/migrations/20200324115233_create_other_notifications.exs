defmodule Euphoriafx.Repo.Migrations.CreateOtherNotifications do
  use Ecto.Migration

  def change do
    create table(:other_notifications) do
      add :notification, :text
      add :is_viewed, :boolean, default: false, null: false
      add :user_id, references(:users)
      add :package_id, references(:packages)
      timestamps()
    end

  end
end
