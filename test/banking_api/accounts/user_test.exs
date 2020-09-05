defmodule BankingApi.Accounts.UserTest do
  use BankingApi.DataCase

  alias BankingApi.Accounts.User

  @valid_attrs %{
    email: "name@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd",
    role: "admin"
  }
  @valid_attrs_without_role %{
    email: "another_name@email.com",
    first_name: "another first name",
    last_name: "another last name",
    password: "pwd",
    password_confirmation: "pwd"
  }
  @invalid_attrs %{}
  @invalid_email_format %{
    email: "another_name@email",
    first_name: "another first name",
    last_name: "another last name",
    password: "pwd",
    password_confirmation: "pwd"
  }
  @mismatched_passwords %{
    email: "another_name@email",
    first_name: "another first name",
    last_name: "another last name",
    password: "pwd",
    password_confirmation: "different"
  }

  describe "test User.changeset/2 function" do
    test "changeset with valid attributes" do
      # do
      changeset = User.changeset(%User{}, @valid_attrs)

      # assert
      assert changeset.valid?
    end

    test "changeset without the role attribute should return true because of the default value for it" do
      # do
      changeset = User.changeset(%User{}, @valid_attrs_without_role)

      # assert
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      # do
      changeset = User.changeset(%User{}, @invalid_attrs)

      # assert
      refute changeset.valid?
    end

    test "changeset with invalid email format" do
      # do
      changeset = User.changeset(%User{}, @invalid_email_format)

      # assert
      refute changeset.valid?
    end

    test "changeset with mismatched passwords" do
      # do
      changeset = User.changeset(%User{}, @mismatched_passwords)

      # assert
      refute changeset.valid?
    end
  end
end
