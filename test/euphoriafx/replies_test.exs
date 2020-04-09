defmodule Euphoriafx.RepliesTest do
  use Euphoriafx.DataCase

  alias Euphoriafx.Replies

  describe "replies" do
    alias Euphoriafx.Replies.Reply

    @valid_attrs %{reply: "some reply"}
    @update_attrs %{reply: "some updated reply"}
    @invalid_attrs %{reply: nil}

    def reply_fixture(attrs \\ %{}) do
      {:ok, reply} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Replies.create_reply()

      reply
    end

    test "list_replies/0 returns all replies" do
      reply = reply_fixture()
      assert Replies.list_replies() == [reply]
    end

    test "get_reply!/1 returns the reply with given id" do
      reply = reply_fixture()
      assert Replies.get_reply!(reply.id) == reply
    end

    test "create_reply/1 with valid data creates a reply" do
      assert {:ok, %Reply{} = reply} = Replies.create_reply(@valid_attrs)
      assert reply.reply == "some reply"
    end

    test "create_reply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Replies.create_reply(@invalid_attrs)
    end

    test "update_reply/2 with valid data updates the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{} = reply} = Replies.update_reply(reply, @update_attrs)
      assert reply.reply == "some updated reply"
    end

    test "update_reply/2 with invalid data returns error changeset" do
      reply = reply_fixture()
      assert {:error, %Ecto.Changeset{}} = Replies.update_reply(reply, @invalid_attrs)
      assert reply == Replies.get_reply!(reply.id)
    end

    test "delete_reply/1 deletes the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{}} = Replies.delete_reply(reply)
      assert_raise Ecto.NoResultsError, fn -> Replies.get_reply!(reply.id) end
    end

    test "change_reply/1 returns a reply changeset" do
      reply = reply_fixture()
      assert %Ecto.Changeset{} = Replies.change_reply(reply)
    end
  end
end
