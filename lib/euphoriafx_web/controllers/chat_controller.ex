defmodule EuphoriafxWeb.ChatController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.Chats
  alias Euphoriafx.Accounts
  alias Euphoriafx.Packages
  alias Euphoriafx.Chats.Chat

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    chats = Chats.list_chats()
    render(conn, "index.json", chats: chats)
  end

  def create(conn, %{"chat" => chat_params}) do

    user_one = Accounts.get_user!(chat_params["user_one_id"])
    user_two = Accounts.get_user!(chat_params["user_two_id"])
    package = Packages.get_package!(chat_params["package_id"])

    with {:ok, %Chat{} = chat} <- Chats.create_chat(package, user_one, user_two, chat_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.chat_path(conn, :show, chat))
      |> render("show.json", chat: chat)
    end
  end

  def show(conn, %{"id" => id}) do
    chat = Chats.get_chat!(id)
    render(conn, "show.json", chat: chat)
  end

  def update(conn, %{"id" => id, "chat" => chat_params}) do
    chat = Chats.get_chat!(id)

    with {:ok, %Chat{} = chat} <- Chats.update_chat(chat, chat_params) do
      render(conn, "show.json", chat: chat)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat = Chats.get_chat!(id)

    with {:ok, %Chat{}} <- Chats.delete_chat(chat) do
      send_resp(conn, :no_content, "")
    end
  end
end
