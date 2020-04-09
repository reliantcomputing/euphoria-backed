defmodule EuphoriafxWeb.ChatMessageController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.ChatMessages
  alias Euphoriafx.Chats
  alias Euphoriafx.ChatMessages.ChatMessage

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    chat_messages = ChatMessages.list_chat_messages()
    render(conn, "index.json", chat_messages: chat_messages)
  end

  def create(conn, %{"chat_message" => chat_message_params}) do
    chat = Chats.get_chat!(chat_message_params["chat_id"])
    with {:ok, %ChatMessage{} = chat_message} <- ChatMessages.create_chat_message(chat, chat_message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.chat_message_path(conn, :show, chat_message))
      |> render("show.json", chat_message: chat_message)
    end
  end

  def show(conn, %{"id" => id}) do
    chat_message = ChatMessages.get_chat_message!(id)
    render(conn, "show.json", chat_message: chat_message)
  end

  def update(conn, %{"id" => id, "chat_message" => chat_message_params}) do
    chat_message = ChatMessages.get_chat_message!(id)

    with {:ok, %ChatMessage{} = chat_message} <- ChatMessages.update_chat_message(chat_message, chat_message_params) do
      render(conn, "show.json", chat_message: chat_message)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat_message = ChatMessages.get_chat_message!(id)

    with {:ok, %ChatMessage{}} <- ChatMessages.delete_chat_message(chat_message) do
      send_resp(conn, :no_content, "")
    end
  end
end
