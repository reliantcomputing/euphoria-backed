defmodule EuphoriafxWeb.AuthView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.UserView

  def render("create-show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      image_path: user.image_path,
      }
  end

  def render("user-token.json", %{user: user, token: token}) do
    %{
      user: render_one(user, UserView, "user-children.json"),
      token: token
    }
  end
end
