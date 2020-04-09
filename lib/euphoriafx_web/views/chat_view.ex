defmodule EuphoriafxWeb.ChatView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.ChatView
  alias EuphoriafxWeb.UserView
  alias EuphoriafxWeb.ChatMessageView
  alias EuphoriafxWeb.PackageView

  def render("index.json", %{chats: chats}) do
    %{data: render_many(chats, ChatView, "chat-children.json")}
  end

  def render("show.json", %{chat: chat}) do
    %{data: render_one(chat, ChatView, "chat.json")}
  end

  def render("chat.json", %{chat: chat}) do
    %{id: chat.id}
  end

  def render("chat-children.json", %{chat: chat}) do
    %{id: chat.id,
      package_id: chat.package.id,
      updated_at: chat.updated_at,
      users: render_many(chat.users, UserView, "user.json"),
      messages: render_many(chat.messages, ChatMessageView, "chat_message.json")}
  end
end
