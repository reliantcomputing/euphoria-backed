defmodule EuphoriafxWeb.ChatMessageControllerTest do
  use EuphoriafxWeb.ConnCase

  alias Euphoriafx.ChatMessages
  alias Euphoriafx.ChatMessages.ChatMessage

  @create_attrs %{
    message: "some message",
    seen: true
  }
  @update_attrs %{
    message: "some updated message",
    seen: false
  }
  @invalid_attrs %{message: nil, seen: nil}

  def fixture(:chat_message) do
    {:ok, chat_message} = ChatMessages.create_chat_message(@create_attrs)
    chat_message
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all chat_messages", %{conn: conn} do
      conn = get(conn, Routes.chat_message_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create chat_message" do
    test "renders chat_message when data is valid", %{conn: conn} do
      conn = post(conn, Routes.chat_message_path(conn, :create), chat_message: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.chat_message_path(conn, :show, id))

      assert %{
               "id" => id,
               "message" => "some message",
               "seen" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.chat_message_path(conn, :create), chat_message: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update chat_message" do
    setup [:create_chat_message]

    test "renders chat_message when data is valid", %{conn: conn, chat_message: %ChatMessage{id: id} = chat_message} do
      conn = put(conn, Routes.chat_message_path(conn, :update, chat_message), chat_message: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.chat_message_path(conn, :show, id))

      assert %{
               "id" => id,
               "message" => "some updated message",
               "seen" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, chat_message: chat_message} do
      conn = put(conn, Routes.chat_message_path(conn, :update, chat_message), chat_message: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete chat_message" do
    setup [:create_chat_message]

    test "deletes chosen chat_message", %{conn: conn, chat_message: chat_message} do
      conn = delete(conn, Routes.chat_message_path(conn, :delete, chat_message))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.chat_message_path(conn, :show, chat_message))
      end
    end
  end

  defp create_chat_message(_) do
    chat_message = fixture(:chat_message)
    {:ok, chat_message: chat_message}
  end
end
