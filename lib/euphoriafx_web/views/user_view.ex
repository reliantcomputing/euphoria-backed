defmodule EuphoriafxWeb.UserView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.UserView
  alias EuphoriafxWeb.TypeView
  alias EuphoriafxWeb.FeedView
  alias EuphoriafxWeb.CommentView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user-children.json")}
  end

  def render("show.json", %{user: user}) do
    %{data:
      %{
        username: user.username,
        email: user.email,
        created_at: user.inserted_at,
        updated_at: user.updated_at,
        image_path: user.image_path,
        type: render_one(user.type, TypeView, "type.json"),
        feeds: render_many(user.feeds, FeedView, "feed.json"),
        comments: render_many(user.comments, CommentView, "comment.json")
        }
      }
  end

  def render("create-show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user-children.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      type_id: user.type.id,
      image_path: user.image_path,
      created_at: user.inserted_at,
      updated_at: user.updated_at,
      type: render_one(user.type, TypeView, "type.json"),
      feeds: render_many(user.feeds, FeedView, "feed-children.json"),
      comments: render_many(user.comments, CommentView, "comment.json")
      }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      image_path: user.image_path,
      created_at: user.inserted_at,
      updated_at: user.updated_at
      }
  end
end
