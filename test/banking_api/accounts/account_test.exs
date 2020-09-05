defmodule BankingApi.Accounts.AccountTest do
  use BankingApi.DataCase

  alias BankingApi.Accounts.Account

  @valid_attrs %{balance: "1000"}
  @invalid_attrs %{}

  describe "test Account.changeset/2 function" do
    test "changeset with valid attributes" do
      # do
      changeset = Account.changeset(%Account{}, @valid_attrs)

      # assert
      assert changeset.valid?
    end

    test "changeset with invalid attributes should return a valid changeset because of the default values" do
      # do
      changeset = Account.changeset(%Account{}, @invalid_attrs)

      # assert
      assert changeset.valid?
    end
  end
end
