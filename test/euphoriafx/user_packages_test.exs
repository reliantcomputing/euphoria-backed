defmodule Euphoriafx.UserPackagesTest do
  use Euphoriafx.DataCase

  alias Euphoriafx.UserPackages

  describe "users_packages" do
    alias Euphoriafx.UserPackages.UserPackage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_package_fixture(attrs \\ %{}) do
      {:ok, user_package} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserPackages.create_user_package()

      user_package
    end

    test "list_users_packages/0 returns all users_packages" do
      user_package = user_package_fixture()
      assert UserPackages.list_users_packages() == [user_package]
    end

    test "get_user_package!/1 returns the user_package with given id" do
      user_package = user_package_fixture()
      assert UserPackages.get_user_package!(user_package.id) == user_package
    end

    test "create_user_package/1 with valid data creates a user_package" do
      assert {:ok, %UserPackage{} = user_package} = UserPackages.create_user_package(@valid_attrs)
    end

    test "create_user_package/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserPackages.create_user_package(@invalid_attrs)
    end

    test "update_user_package/2 with valid data updates the user_package" do
      user_package = user_package_fixture()
      assert {:ok, %UserPackage{} = user_package} = UserPackages.update_user_package(user_package, @update_attrs)
    end

    test "update_user_package/2 with invalid data returns error changeset" do
      user_package = user_package_fixture()
      assert {:error, %Ecto.Changeset{}} = UserPackages.update_user_package(user_package, @invalid_attrs)
      assert user_package == UserPackages.get_user_package!(user_package.id)
    end

    test "delete_user_package/1 deletes the user_package" do
      user_package = user_package_fixture()
      assert {:ok, %UserPackage{}} = UserPackages.delete_user_package(user_package)
      assert_raise Ecto.NoResultsError, fn -> UserPackages.get_user_package!(user_package.id) end
    end

    test "change_user_package/1 returns a user_package changeset" do
      user_package = user_package_fixture()
      assert %Ecto.Changeset{} = UserPackages.change_user_package(user_package)
    end
  end
end
