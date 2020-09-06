defmodule BankingApi.OperationsTest do
  use BankingApi.DataCase

  alias BankingApi.Operations
  alias BankingApi.Repo
  alias BankingApi.Accounts

  @your_account_balance_is "O saldo de sua conta bancária é R$"
  @denied_operation "Operação negada"
  @you_tried_to_operate_an_amount_greater_than_your_balance "Você tentou operar um valor maior do que o permitido para a sua conta"

  @user_from_params %{
    email: "email@email.com",
    first_name: "first_name",
    last_name: "last_name",
    password: "pwd",
    password_confirmation: "pwd"
  }

  @user_to_params %{
    email: "another@email.com",
    first_name: "different first name",
    last_name: "different last name",
    password: "another_pwd",
    password_confirmation: "another_pwd"
  }

  def create_user_and_account(params) do
    {:ok, user, _account} = Accounts.create_user(params)
    Repo.preload(user, :accounts)
  end

  describe "Test transfer operations" do
    test "Operations.transfer/3 should operate with success" do
      # When
      user_from = create_user_and_account(@user_from_params)
      user_to = create_user_and_account(@user_to_params)

      # do
      {atom, _message} =
        Operations.transfer(user_from.accounts, Integer.to_string(user_to.accounts.id), 100)

      # assert
      assert atom == :ok
    end

    test "Operations.transfer/3 should fail when the amount operated is greatter than the balance" do
      # when
      user_from = create_user_and_account(@user_from_params)
      user_to = create_user_and_account(@user_to_params)

      # do
      {atom, message} =
        Operations.transfer(user_from.accounts, Integer.to_string(user_to.accounts.id), 9_999_999)

      # assert error message
      assert atom == :error

      assert message ==
               "#{@denied_operation}. #{@you_tried_to_operate_an_amount_greater_than_your_balance}. #{
                 @your_account_balance_is
               } #{user_from.accounts.balance}."
    end

    test "Operations.transfer/3 should fail when the target account does not exist" do
      # when
      user_from = create_user_and_account(@user_from_params)

      # do
      {atom, _message} = Operations.transfer(user_from.accounts, "5", 100)

      # assert
      assert atom == :error
    end
  end

  describe "Test withdraw operations" do
    test "Operations.withdraw/2 should operate with success" do
      # when
      user_from = create_user_and_account(@user_from_params)

      # do
      {atom, _message} = Operations.withdraw(user_from.accounts, 100)

      # assert
      assert atom == :ok
    end

    test "Operations.withdraw/2 should fail when the amount operated is greatter than the balance" do
      # when
      user_from = create_user_and_account(@user_from_params)

      # do
      {atom, message} = Operations.withdraw(user_from.accounts, 99_999)

      # assert
      assert message ==
               "#{@denied_operation}. #{@you_tried_to_operate_an_amount_greater_than_your_balance}. #{
                 @your_account_balance_is
               } #{user_from.accounts.balance}."

      assert atom == :error
    end
  end

  describe "test perform_operation/3 functions" do
    test "perform_operation(account, amount, :sub) should subtract from the account balance" do
      # when
      user_from = create_user_and_account(@user_from_params)

      # assert
      assert user_from.accounts.balance == Decimal.new("1000.00")

      # do
      changeset = Operations.perform_operation(user_from.accounts, 100, :sub)

      # assert
      assert changeset.changes == %{balance: Decimal.new("900.00")}
    end

    test "perform_operation(account, amount, :sum) should add the amount to the account balance" do
      # when
      user_from = create_user_and_account(@user_from_params)

      # assert
      assert user_from.accounts.balance == Decimal.new("1000.00")

      # do
      changeset = Operations.perform_operation(user_from.accounts, 100, :sum)

      # assert
      assert changeset.changes == %{balance: Decimal.new("1100.00")}
    end
  end

  describe "validate amount operated" do
    test "Operations.validate_amount/1 should return the amount in Decimal type" do
      # do
      {:ok, amount} = Operations.validate_amount("100.00")

      # assert
      assert Decimal.decimal?(amount)
    end

    test "Operations.validate_amount/1 should return an error when the amount has comma" do
      # do
      {atom, _message} = Operations.validate_amount("100,00")

      # assert
      assert atom == :error
    end

    test "Operations.validate_amount/1 should return an error when the amount is not a number" do
      # do
      {atom, _message} = Operations.validate_amount("hey there")

      # assert
      assert atom == :error
    end
  end
end
