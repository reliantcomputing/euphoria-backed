defmodule Euphoriafx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string
    field :image_path, :string

    # Parents
    belongs_to :type, Euphoriafx.Accounts.Type
    belongs_to :package, Euphoriafx.Packages.Package

    # children
    has_many :feeds, Euphoriafx.Feeds.Feed
    has_many :comments, Euphoriafx.Comments.Comment
    has_many :replies, Euphoriafx.Replies.Reply

    many_to_many :chats, Euphoriafx.Chats.Chat, join_through: "users_chats"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do

    user
    |> cast(attrs, [:username, :email, :password, :image_path])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password, Bcrypt.Base.hash_password(password, Bcrypt.gen_salt(12, true)))
      _ ->
          changeset
    end
  end
end
