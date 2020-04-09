defmodule EuphoriafxWeb.CommentView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.CommentView
  alias EuphoriafxWeb.UserView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment-parent.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("create-show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment-parent.json")}
  end

  def render("comment-parent.json", %{comment: comment}) do
    %{id: comment.id,
      comment: comment.comment,
      created_at: comment.inserted_at,
      user: render_one(comment.user, UserView, "user.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      comment: comment.comment}
  end
end
