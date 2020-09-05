defmodule BankingApi.Transactions.TransactionTest do
  use BankingApi.DataCase

  alias BankingApi.Transactions.Transaction

  @valid_attrs %{
    value: "100.00",
    account_from: "1",
    account_to: "2",
    type: "transfer",
    date: "2020-02-01"
  }
  @invalid_attrs %{}

  describe "test Transaction.changeset/2 function" do
    test "changeset with valid attributes" do
      # do
      changeset = Transaction.changeset(%Transaction{}, @valid_attrs)

      # assert
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      # do
      changeset = Transaction.changeset(%Transaction{}, @invalid_attrs)

      # assert
      refute changeset.valid?
    end
  end
end
