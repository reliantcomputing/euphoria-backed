defmodule EuphoriafxWeb.FolderView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.FolderView

  def render("index.json", %{folders: folders}) do
    %{data: render_many(folders, FolderView, "folder.json")}
  end

  def render("show.json", %{folder: folder}) do
    %{data: render_one(folder, FolderView, "folder.json")}
  end

  def render("create-show.json", %{folder: folder}) do
    %{data: render_one(folder, FolderView, "folder.json")}
  end

  def render("folder.json", %{folder: folder}) do
    %{id: folder.id,
      name: folder.name,
      created_at: folder.inserted_at,
      updated_at: folder.updated_at
    }
  end
end
