defmodule EuphoriafxWeb.PageController do
  use EuphoriafxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
