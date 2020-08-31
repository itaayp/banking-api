defmodule BankingApi.GuardianTest do
  use BankingApi.DataCase

  alias BankingApi.Accounts
  alias BankingApi.Accounts.Auth.Guardian

  @user_map %{
    email: "email@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd"
  }

  describe "test authentication" do
    test "authenticate/2 should authorize the user when the email and password are correct" do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_map)

      # assert
      {:ok, _user_authenticated, _token} = Guardian.authenticate(user.email, user.password)
    end

    test "authenticate/2 should unauthorize the user when the password is incorrect" do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_map)

      # assert
      assert {:error, :unauthorized} = Guardian.authenticate(user.email, "wrong password")
    end

    test "authenticate/2 should unauthorize the user when the email is incorrect" do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_map)

      # assert
      assert {:error, :unauthorized} = Guardian.authenticate("wrong@email.com", user.password)
    end
  end
end
