defmodule BankingApi.AccountsTest do
  use BankingApi.DataCase

  alias BankingApi.Accounts

  @password_validation_error_message "A confirmacao de senha nao esta igual a senha digitada."
  @invalid_email_format_error_message "Email em formato invalido."

  @valid_params %{
    email: "valid_email@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd"
  }

  @invalid_email_format %{
    email: "invalid email format",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd"
  }

  @different_passwords %{
    email: "email@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "other_pwd"
  }

  @missing_params %{
    email: "email@email.com",
    first_name: "first name",
    password: "pwd",
  }


  describe "user-related tests" do
    test "get_user!/1 should return the user from the given id" do
      # when
      {:ok, user, _account} = Accounts.create_user(@valid_params)

      # assert
      assert Accounts.get_user!(user.id).id == user.id
    end

    test "create_user/1 should create a user when the valid params are used" do
      # when
      {:ok, user, _account} = Accounts.create_user(@valid_params)

      # assert
      assert user.email == "valid_email@email.com"
      assert user.first_name == "first name"
    end

    test "create_user/1 should fail because the passwords doesn't match" do
      # when
      {:error, changeset} = Accounts.create_user(@different_passwords)

      # assert
      assert @password_validation_error_message in errors_on(changeset).password_confirmation
    end

    test "create_user/1 should fail because the email format is invalid" do
      # when
      {:error, changeset} = Accounts.create_user(@invalid_email_format)

      # assert
      assert @invalid_email_format_error_message in errors_on(changeset).email
    end

    test "create_user/1 should fail because are missing required params for creation" do
      # when
      {:error, changeset} = Accounts.create_user(@missing_params)

      # assert
      assert "can't be blank" in errors_on(changeset).last_name
      assert "can't be blank" in errors_on(changeset).password_confirmation
    end
  end

  describe "account-related tests" do
    test "get!/1 should return the account from the given id" do
      # when
      {:ok, _user, account} = Accounts.create_user(@valid_params)

      # assert
      assert Accounts.get!(account.id).id == account.id
    end
  end
end
