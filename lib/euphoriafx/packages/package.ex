defmodule Euphoriafx.Packages.Package do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packages" do
    field :description, :string
    field :title, :string
    field :price, :integer

    # Children
    has_many :users, Euphoriafx.Accounts.User
    has_many :feeds, Euphoriafx.Feeds.Feed
    has_many :folders, Euphoriafx.Folders.Folder
    has_many :robot_notifications, Euphoriafx.RobotNotifications.RobotNotification
    has_many :team_notifications, Euphoriafx.TeamNotifications.TeamNotification
    has_many :other_notifications, Euphoriafx.OtherNotifications.OtherNotification

    timestamps()
  end

  @doc false
  def changeset(package, attrs) do
    package
    |> cast(attrs, [:title, :description, :price])
    |> validate_required([:title, :description])
  end
end
