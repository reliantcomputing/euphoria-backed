defmodule EuphoriafxWeb.TypeView do
  use EuphoriafxWeb, :view

  alias EuphoriafxWeb.TypeView
  alias EuphoriafxWeb.UserView

  def render("index.json", %{types: types}) do
    %{data: render_many(types, TypeView, "type.json")}
  end

  def render("show.json", %{type: type}) do
    %{data: %{
        id: type.id,
        name: type.name,
        users: render_many(type.users, UserView, "user.json")
        }
      }
  end

  def render("create-show.json", %{type: type}) do
    %{data: render_one(type, TypeView, "type.json")}
  end

  def render("type.json", %{type: type}) do
    %{id: type.id,
      type: type.name}
  end
end
