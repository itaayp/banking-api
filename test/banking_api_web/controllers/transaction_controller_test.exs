defmodule BankingApiWeb.TransactionControllerTest do
  use BankingApiWeb.ConnCase

  alias BankingApi.Accounts
  alias BankingApi.Transactions
  import BankingApi.Accounts.Auth.Guardian

  @user_admin_params %{
    email: "email@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd",
    role: "admin"
  }

  setup %{conn: conn} do
    transactions_repo()

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "test generate_entire_life_report/0" do
    test "generate_entire_life_report/0 should return a report containing a list of transactions and the total amount operated", %{conn: conn} do
      # Authenticate user
      {:ok, user, _account} = Accounts.create_user(@user_admin_params)
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      # do
      conn = get(conn, Routes.transaction_path(conn, :generate_entire_life_report))
      result = json_response(conn, 200)

      # assert
      amount_operated = Map.get(result, "Total operado")
      assert amount_operated == "R$ 1050.00"

      transactions = Map.get(result, "Operações") |> Enum.count()
      assert transactions == 6
    end
  end

  describe "test generate_anual_report" do
    test "generate_anual_report/1 should return an anual report containing a list of transactions and the total amount operated", %{conn: conn} do
      # Authenticate user
      {:ok, user, _account} = Accounts.create_user(@user_admin_params)
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      #do
      conn = get(conn, Routes.transaction_path(conn, :generate_anual_report, "2020"))
      result = json_response(conn, 200)

      # assert
      amount_operated = Map.get(result, "Total operado")
      assert amount_operated == "R$ 950.00"

      transactions = Map.get(result, "Operações") |> Enum.count()
      assert transactions == 5
    end
  end

  describe "test generate_monthly_report" do
    test "generate_monthly_report should return a monthly report containing a list of transactions and the total amount operated", %{conn: conn} do
      # Authenticate user
      {:ok, user, _account} = Accounts.create_user(@user_admin_params)
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      # do
      conn = get(conn, Routes.transaction_path(conn, :generate_monthly_report, "2020", "02"))
      result = json_response(conn, 200)

      # assert
      amount_operated = Map.get(result, "Total operado")
      assert amount_operated == "R$ 150.00"

      transactions = Map.get(result, "Operações") |> Enum.count()
      assert transactions == 1
    end
  end

  describe "test generate_daily_report" do
    test "generate_daily_report should return a daily report containing a list of transactions and the total amount operated", %{conn: conn} do
      # Authenticate user
      {:ok, user, _account} = Accounts.create_user(@user_admin_params)
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      # do
      conn = get(conn, Routes.transaction_path(conn, :generate_daily_report, "2020-12-09"))
      result = json_response(conn, 200)

      # assert
      amount_operated = Map.get(result, "Total operado")
      assert amount_operated == "R$ 50.00"

      transactions = Map.get(result, "Operações") |> Enum.count()
      assert transactions == 1
    end
  end

  def transactions_repo do
    [
      %{
        value: "50",
        account_from: "123123",
        type: "transfer",
        account_to: "112112",
        date: ~D[2020-12-09]
      },
      %{
        value: "100",
        account_from: "123123",
        type: "withdraw",
        account_to: "112112",
        date: ~D[2020-11-08]
      },
      %{
        value: "100",
        account_from: "123123",
        type: "transfer",
        account_to: "112112",
        date: ~D[2020-11-07]
      },
      %{
        value: "550",
        account_from: "123123",
        type: "transfer",
        account_to: "112112",
        date: ~D[2020-11-17]
      },
      %{
        value: "150",
        account_from: "123123",
        type: "transfer",
        account_to: "112112",
        date: ~D[2020-02-07]
      },
      %{
        value: "100",
        account_from: "123123",
        type: "transfer",
        account_to: "112112",
        date: ~D[2018-10-07]
      }
    ]
    |> Enum.map(fn transaction -> Transactions.insert_transaction(transaction) end)
  end
end
