defmodule EuphoriafxWeb.ReplyControllerTest do
  use EuphoriafxWeb.ConnCase

  alias Euphoriafx.Replies
  alias Euphoriafx.Replies.Reply

  @create_attrs %{
    reply: "some reply"
  }
  @update_attrs %{
    reply: "some updated reply"
  }
  @invalid_attrs %{reply: nil}

  def fixture(:reply) do
    {:ok, reply} = Replies.create_reply(@create_attrs)
    reply
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all replies", %{conn: conn} do
      conn = get(conn, Routes.reply_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reply" do
    test "renders reply when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reply_path(conn, :create), reply: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.reply_path(conn, :show, id))

      assert %{
               "id" => id,
               "reply" => "some reply"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reply_path(conn, :create), reply: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update reply" do
    setup [:create_reply]

    test "renders reply when data is valid", %{conn: conn, reply: %Reply{id: id} = reply} do
      conn = put(conn, Routes.reply_path(conn, :update, reply), reply: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.reply_path(conn, :show, id))

      assert %{
               "id" => id,
               "reply" => "some updated reply"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, reply: reply} do
      conn = put(conn, Routes.reply_path(conn, :update, reply), reply: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reply" do
    setup [:create_reply]

    test "deletes chosen reply", %{conn: conn, reply: reply} do
      conn = delete(conn, Routes.reply_path(conn, :delete, reply))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.reply_path(conn, :show, reply))
      end
    end
  end

  defp create_reply(_) do
    reply = fixture(:reply)
    {:ok, reply: reply}
  end
end
