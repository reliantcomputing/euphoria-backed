defmodule EuphoriafxWeb.FeedView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.FeedView
  alias EuphoriafxWeb.UserView
  alias EuphoriafxWeb.CommentView
  alias EuphoriafxWeb.LikeView

  def render("index.json", %{feeds: feeds}) do
    %{data: render_many(feeds, FeedView, "feed-children.json")}
  end

  def render("show.json", %{feed: feed}) do
    %{data: render_one(feed, FeedView, "feed-children.json")}
  end

  def render("create-show.json", %{feed: feed}) do
    %{data: render_one(feed, FeedView, "feed.json")}
  end

  def render("feed-children.json", %{feed: feed}) do
    %{id: feed.id,
      content: feed.content,
      created_at: feed.inserted_at,
      updated_at: feed.updated_at,
      user: render_one(feed.user, UserView, "user.json"),
      image_path: feed.image_path,
      comments: render_many(feed.comments, CommentView, "comment-parent.json"),
      likes: render_many(feed.likes, LikeView, "like.json")
    }
  end

  def render("feed.json", %{feed: feed}) do
    %{id: feed.id,
      content: feed.content,
      image_path: feed.image_path}
  end
end
