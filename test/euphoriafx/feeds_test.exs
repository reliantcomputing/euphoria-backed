defmodule Euphoriafx.FeedsTest do
  use Euphoriafx.DataCase

  alias Euphoriafx.Feeds

  describe "feeds" do
    alias Euphoriafx.Feeds.Feed

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def feed_fixture(attrs \\ %{}) do
      {:ok, feed} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feeds.create_feed()

      feed
    end

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Feeds.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Feeds.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      assert {:ok, %Feed{} = feed} = Feeds.create_feed(@valid_attrs)
      assert feed.content == "some content"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{} = feed} = Feeds.update_feed(feed, @update_attrs)
      assert feed.content == "some updated content"
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert feed == Feeds.get_feed!(feed.id)
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Feeds.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed(feed)
    end
  end
end
