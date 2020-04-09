defmodule Euphoriafx.OtherNotifications.OtherNotification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "other_notifications" do
    field :is_viewed, :boolean, default: false
    field :notification, :string

    # Parents
    belongs_to :user, Euphoriafx.Accounts.User
    belongs_to :package, Euphoriafx.Packages.Package

    timestamps()
  end

  @doc false
  def changeset(other_notification, attrs) do
    other_notification
    |> cast(attrs, [:notification, :is_viewed])
    |> validate_required([:notification, :is_viewed])
  end
end
