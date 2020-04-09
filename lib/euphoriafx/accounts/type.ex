defmodule Euphoriafx.Accounts.Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "types" do
    field :name, :string

    # Children
    has_many :users, Euphoriafx.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
