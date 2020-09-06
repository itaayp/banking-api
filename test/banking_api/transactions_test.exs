defmodule BankingApi.TransactionsTest do
  use BankingApi.DataCase

  alias BankingApi.Transactions

  describe "test insert_transaction/1" do
    test "insert_transaction/1 should insert a transaction into the database" do
      # when
      transaction = %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2018-11-17]
      }

      # do
      {atom, db_transaction} = Transactions.insert_transaction(transaction)

      # assert
      assert :ok == atom
      assert "1" == db_transaction.account_from
    end
  end

  describe "Date validation" do
    test "validate_date/2 should return {:ok} when the date is valid" do
      # When
      valid_year = "2020"
      valid_month = "01"

      # Do
      {atom, _success_message} =
        Transactions.validate_date(valid_year, valid_month, "fail message")

      # Assert
      assert atom == :ok
    end

    test "validate_date/2 should return {:error} when the year is invalid" do
      # When
      invalid_year = "20abc20"
      valid_month = "01"

      # Do
      {atom, fail_message} = Transactions.validate_date(invalid_year, valid_month, "fail message")

      # Assert
      assert atom == :error
      assert fail_message == "fail message"
    end

    test "validate_date/2 should return {:error} when the month is invalid" do
      # When
      valid_year = "2020"
      invalid_month = "18"

      # Do
      {atom, fail_message} = Transactions.validate_date(valid_year, invalid_month, "fail message")

      # Assert
      assert atom == :error
      assert fail_message == "fail message"
    end
  end

  describe "Test the creation of all report types" do
    test "all/0 should return all the existing transactions in the database" do
      # When
      transactions_repo()

      # Do
      transactions = Transactions.all()

      # Assert
      assert Enum.count(transactions.transactions) == 6
    end

    test "year/1 should return all the existing transactions filtered by year" do
      # When
      transactions_repo()

      # Do
      transactions = Transactions.year("2020")

      # Assert
      assert Enum.count(transactions.transactions) == 4
    end

    test "month/2 should return all the existing transactions filtered by month" do
      # When
      transactions_repo()

      # Do
      transactions = Transactions.month("2019", "08")

      # Assert
      assert Enum.count(transactions.transactions) == 1
    end

    test "day/1 should return all the existing transactions filtered by day" do
      # When
      transactions_repo()

      # Do
      transactions = Transactions.day("2020-08-30")

      # Assert
      assert Enum.count(transactions.transactions) == 2
    end
  end

  def transactions_repo do
    [
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2020-08-30]
      },
      %{
        value: "100",
        account_from: "1",
        type: "withdraw",
        account_to: "~",
        date: ~D[2020-08-30]
      },
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2020-08-29]
      },
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2020-08-28]
      },
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2019-08-27]
      },
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2018-08-26]
      }
    ]
    |> Enum.map(fn transaction -> Transactions.insert_transaction(transaction) end)
  end
end
