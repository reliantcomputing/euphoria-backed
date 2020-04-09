defmodule Euphoriafx.TeamNotifications.TeamNotification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "team_notifications" do
    field :is_viewed, :boolean, default: false
    field :notification, :string

    # Parents
    belongs_to :user, Euphoriafx.Accounts.User
    belongs_to :package, Euphoriafx.Packages.Package

    timestamps()
  end

  @doc false
  def changeset(team_notification, attrs) do
    team_notification
    |> cast(attrs, [:notification, :is_viewed])
    |> validate_required([:notification, :is_viewed])
  end
end
