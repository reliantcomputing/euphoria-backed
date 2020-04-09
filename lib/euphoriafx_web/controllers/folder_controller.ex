defmodule EuphoriafxWeb.FolderController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.Folders
  alias Euphoriafx.Folders.Folder
  alias Euphoriafx.Packages

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    folders = Folders.list_folders()
    render(conn, "index.json", folders: folders)
  end

  def create(conn, %{"folder" => folder_params}) do
    package = Packages.get_package!(folder_params["package_id"])
    with {:ok, %Folder{} = folder} <- Folders.create_folder(package, folder_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.folder_path(conn, :show, folder))
      |> render("create-show.json", folder: folder)
    end
  end

  def show(conn, %{"id" => id}) do
    folder = Folders.get_folder!(id)
    render(conn, "show.json", folder: folder)
  end

  def update(conn, %{"id" => id, "folder" => folder_params}) do
    folder = Folders.get_folder!(id)

    with {:ok, %Folder{} = folder} <- Folders.update_folder(folder, folder_params) do
      render(conn, "show.json", folder: folder)
    end
  end

  def delete(conn, %{"id" => id}) do
    folder = Folders.get_folder!(id)

    with {:ok, %Folder{}} <- Folders.delete_folder(folder) do
      send_resp(conn, :no_content, "")
    end
  end
end
