defmodule EuphoriafxWeb.CommentController do
  use EuphoriafxWeb, :controller

  alias Euphoriafx.Comments
  alias Euphoriafx.Feeds
  alias Euphoriafx.Accounts
  alias Euphoriafx.Comments.Comment

  action_fallback EuphoriafxWeb.FallbackController

  def index(conn, _params) do
    comments = Comments.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    feed = Feeds.get_feed!(comment_params["feed_id"])
    user = Accounts.get_user!(comment_params["user_id"])
    with {:ok, %Comment{} = comment} <- Comments.create_comment(feed, user, comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
      |> render("create-show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Comments.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
