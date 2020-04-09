defmodule EuphoriafxWeb.ChatMessageView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.ChatMessageView

  def render("index.json", %{chat_messages: chat_messages}) do
    %{data: render_many(chat_messages, ChatMessageView, "chat_message.json")}
  end

  def render("show.json", %{chat_message: chat_message}) do
    %{data: render_one(chat_message, ChatMessageView, "chat_message.json")}
  end

  def render("chat_message.json", %{chat_message: chat_message}) do
    %{id: chat_message.id,
      created_at: chat_message.inserted_at,
      message: chat_message.message,
      user_id: chat_message.user_id,
      seen: chat_message.seen}
  end
end
