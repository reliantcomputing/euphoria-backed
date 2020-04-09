defmodule Euphoriafx.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :path, :text
      add :folder_id, references(:folders)
      timestamps()
    end

  end
end
