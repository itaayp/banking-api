defmodule BankingApiWeb.OperationControllerTest do
  use BankingApiWeb.ConnCase

  alias BankingApi.Repo
  alias BankingApi.Accounts
  import BankingApi.Accounts.Auth.Guardian

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

  def create_user_and_account() do
    {:ok, user, _account} = Accounts.create_user(@user_from_params)
    Repo.preload(user, :accounts)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Test transfer operations" do
    test "OperationController.transfer/2 should update user_from.accounts.balance and user_to.accounts.balance", %{conn: conn} do
      # Authenticate user_from
      user_from = create_user_and_account()
      {:ok, token, _} = encode_and_sign(user_from, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      amount_operated = "100"

      # Create user_to
      {:ok, user_to, _account} = Accounts.create_user(@user_to_params)
      user_to = Repo.preload(user_to, :accounts)

      # assert user_to.accounts.balance before the transfer
      assert user_to.accounts.balance == Decimal.new("1000.00")

      # do
      transfer_params = %{"to_account" => Integer.to_string(user_to.accounts.id), "amount" => amount_operated}
      conn = put(conn, Routes.operation_path(conn, :transfer), transfer_params)

      # assert user_to.accounts.balance after the transfer
      conn = get(conn, Routes.user_path(conn, :show, id: user_from.id))
      result = json_response(conn, 200)["Informações da conta"]
      assert "R$ 900.00" == Map.get(result, "saldo em conta")
    end

    test "OperationController.transfer/2 should return an error when the amount operated is greatter than the balance", %{conn: conn} do
      # Authenticate user_from
      user_from = create_user_and_account()
      {:ok, token, _} = encode_and_sign(user_from, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      amount_operated = "9999999"

      # Create user_to
      {:ok, user_to, _account} = Accounts.create_user(@user_to_params)
      user_to = Repo.preload(user_to, :accounts)

      # assert user_to.accounts.balance before the transfer
      assert user_to.accounts.balance == Decimal.new("1000.00")

      # do
      transfer_params = %{"to_account" => Integer.to_string(user_to.accounts.id), "amount" => amount_operated}
      conn = put(conn, Routes.operation_path(conn, :transfer), transfer_params)
      result = json_response(conn, 422)

      # assert error message
      expected_message = %{"erro" => "#{@denied_operation}. #{@you_tried_to_operate_an_amount_greater_than_your_balance}. #{@your_account_balance_is} #{user_from.accounts.balance}."}
      assert result == expected_message

      # assert user_to.accounts.balance after the transfer
      conn = get(conn, Routes.user_path(conn, :show, id: user_from.id))
      result = json_response(conn, 200)["Informações da conta"]
      assert "R$ 1000.00" == Map.get(result, "saldo em conta")
    end

    test "OperationController.transfer/2 should return an error when the target account does not exist", %{conn: conn} do
      # Authenticate user_from
      user_from = create_user_and_account()
      {:ok, token, _} = encode_and_sign(user_from, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      amount_operated = "100"

      # do
      transfer_params = %{"to_account" => "23345621454", "amount" => amount_operated}
      conn = put(conn, Routes.operation_path(conn, :transfer), transfer_params)
      result = json_response(conn, 422)

      # assert error message
      expected_message = %{"erro" => "A conta que você tentou transferir não existe."}
      assert result == expected_message

      # assert user_to.accounts.balance after the transfer
      conn = get(conn, Routes.user_path(conn, :show, id: user_from.id))
      result = json_response(conn, 200)["Informações da conta"]
      assert "R$ 1000.00" == Map.get(result, "saldo em conta")
    end
  end

  describe "Test withdraw operations" do
    test "OperationController.withdraw/2 should update the user_from.accounts.balance", %{conn: conn} do
      # Authenticate user_from
      user_from = create_user_and_account()
      {:ok, token, _} = encode_and_sign(user_from, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      amount_operated = "100"

      # Assert user_from.accounts.balance before the withdraw
      assert user_from.accounts.balance == Decimal.new("1000.00")

      # do
      withdraw_params = %{"amount" => amount_operated}
      conn = put(conn, Routes.operation_path(conn, :withdraw), withdraw_params)

      # assert user_to.accounts.balance after the withdraw
      conn = get(conn, Routes.user_path(conn, :show, id: user_from.id))
      result = json_response(conn, 200)["Informações da conta"]
      assert "R$ 900.00" == Map.get(result, "saldo em conta")
    end

    test "OperationController.withdraw/2 should return an error when the amount operated is greatter than the balance", %{conn: conn} do
      # Authenticate user_from
      user_from = create_user_and_account()
      {:ok, token, _} = encode_and_sign(user_from, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      amount_operated = "9999999"

      # assert user_from.accounts.balance before the transfer
      assert user_from.accounts.balance == Decimal.new("1000.00")

      # do
      withdraw_params = %{"amount" => amount_operated}
      conn = put(conn, Routes.operation_path(conn, :withdraw), withdraw_params)
      result = json_response(conn, 422)

      # assert error message
      expected = %{"erro" => "#{@denied_operation}. #{@you_tried_to_operate_an_amount_greater_than_your_balance}. #{@your_account_balance_is} #{user_from.accounts.balance}."}
      assert result == expected

      # assert user_to.accounts.balance after the withdraw
      conn = get(conn, Routes.user_path(conn, :show, id: user_from.id))
      result = json_response(conn, 200)["Informações da conta"]
      assert "R$ 1000.00" == Map.get(result, "saldo em conta")    end
  end
end
