defmodule EuphoriafxWeb.ChatChannel do
  use EuphoriafxWeb, :channel

  def join("chats:" <> chat_id, payload, socket) do
    if authorized?(payload) do
      {:ok, assign(socket, :chat_id, String.to_integer(chat_id))}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # sending a message to requests from the client
  def handle_in("new_chat", payload, socket) do
    broadcast!(socket, "new_chat", %{
      "chat_message": payload["chat_message"]
      })
    {:reply, :ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
