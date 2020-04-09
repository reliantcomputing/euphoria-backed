defmodule EuphoriafxWeb.PackageView do
  use EuphoriafxWeb, :view
  alias EuphoriafxWeb.PackageView
  alias EuphoriafxWeb.RobotNotificationView
  alias EuphoriafxWeb.TeamNotificationView
  alias EuphoriafxWeb.OtherNotificationView
  alias EuphoriafxWeb.FeedView
  alias EuphoriafxWeb.FolderView
  alias EuphoriafxWeb.UserView

  def render("index.json", %{packages: packages}) do
    %{data: render_many(packages, PackageView, "package-children.json")}
  end

  def render("show.json", %{package: package}) do
    %{data: render_one(package, PackageView, "package-children.json")}
  end

  def render("create-show.json", %{package: package}) do
    %{data: render_one(package, PackageView, "package.json")}
  end

  def render("package.json", %{package: package}) do
    %{id: package.id,
      title: package.title,
      price: package.price,
      created_at: package.inserted_at,
      updated_at: package.updated_at,
      description: package.description}
  end
  def render("package-children.json", %{package: package}) do
    %{id: package.id,
      title: package.title,
      price: package.price,
      created_at: package.inserted_at,
      updated_at: package.updated_at,
      description: package.description,
      robot_notifications: render_many(package.robot_notifications, RobotNotificationView, "robot_notification.json"),
      team_notifications: render_many(package.team_notifications, TeamNotificationView, "team_notification.json"),
      other_notifications: render_many(package.other_notifications, OtherNotificationView, "other_notification.json"),
      folders: render_many(package.folders, FolderView, "folder.json"),
      users: render_many(package.users, UserView, "user.json"),
      feeds: render_many(package.feeds, FeedView, "feed.json"),
    }
  end
end
