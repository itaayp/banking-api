defmodule BankingApi.Transactions.HelperTest do
  use BankingApi.DataCase

  alias BankingApi.Transactions
  alias BankingApi.Transactions.Helper

  describe "Validate queries" do
    test "Helper.list_transactions/0 should return all existing transactions" do
      # when
      transactions_repo()

      # do
      transactions = Helper.list_transactions()

      # assert
      assert Enum.count(transactions) == 7
    end

    test "Helper.query_by_year(2019)/1 should return all existing transactions filtered by year" do
      # when
      transactions_repo()

      # do
      report = Helper.query_by_year(2019)

      # assert
      assert Enum.count(report.transactions) == 1
    end

    test "Helper.query_by_month/2 should return all existing transactions filtered by month" do
      # when
      transactions_repo()

      # do
      report = Helper.query_by_month(2019, 10)

      # assert
      assert Enum.count(report.transactions) == 1
    end

    test "Helper.query_by_day/1 should return all existing transactions filtered by day" do
      # when
      transactions_repo()

      # do
      report = Helper.query_by_day("2018-10-05")

      # assert
      assert Enum.count(report) == 2
    end

    test "Helper.do_query/2 should return one report" do
      # When
      start_date = "2019-01-01"
      end_date = "2019-12-31"
      transactions_repo()

      # do
      report = Helper.do_query(start_date, end_date)

      # assert
      assert Enum.count(report.transactions) == 1
    end
  end

  describe "create report" do
    test "Helper.create_report/1 should return a report from a list of transactions" do
      # when
      transaction = transactions_list()

      # do
      report = Helper.create_report(transaction)

      # assert
      assert Enum.count(report.transactions) == 2
    end

    test "Helper.sum_amount/1 should return the total amount of a transaction list" do
      # when
      transactions = transactions_list()

      # do
      total_amount = Helper.sum_amount(transactions)

      # assert
      assert total_amount == Decimal.new(430)
    end
  end

  describe "Date validation" do
    test "validate_date/2 should return {:ok} when the date is valid" do
      # When
      valid_date = "2020"

      # Do
      {atom, _success_message} = Helper.validate_date(valid_date, "fail message")

      # Assert
      assert atom == :ok
    end

    test "validate_date/2 should return {:error} when the date is invalid" do
      # When
      invalid_date = "-2020"

      # Do
      {atom, fail_message} = Helper.validate_date(invalid_date, "fail message")

      # Assert
      assert atom == :error
      assert fail_message == "fail message"
    end
  end

  def transactions_list do
    [
      %{
        value: "200",
        account_from: "1",
        type: "withdraw",
        account_to: "~",
        date: ~D[2019-10-30]
      },
      %{
        value: "230",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2020-08-30]
      }
    ]
  end

  def transactions_repo do
    [
      %{
        value: "100",
        account_from: "1",
        type: "withdraw",
        account_to: "~",
        date: ~D[2019-10-30]
      },
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
        date: ~D[2018-10-05]
      },
      %{
        value: "100",
        account_from: "1",
        type: "transfer",
        account_to: "2",
        date: ~D[2018-10-05]
      }
    ]
    |> Enum.map(fn transaction -> Transactions.insert_transaction(transaction) end)
  end
end
