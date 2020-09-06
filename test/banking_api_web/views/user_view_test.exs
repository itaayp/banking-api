defmodule BankingApiWeb.UserViewTest do
  use BankingApiWeb.ConnCase, async: true
  alias BankingApi.Accounts
  alias BankingApi.Repo

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  import BankingApi.Accounts.Auth.Guardian

  @user %{
    email: "email@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd",
    role: "user"
  }

  @account %{
    balance: "1000.00",
    id: "1"
  }

  def create_user_and_account(params) do
    {:ok, user, _account} = Accounts.create_user(params)
    Repo.preload(user, :accounts)
  end

  describe "render show.json" do
    test "render show.json" do
      # do
      user = create_user_and_account(@user)
      result = render_to_string(BankingApiWeb.UserView, "show.json", %{user: user})

      # assert
      assert String.contains?(result, "\"saldo em conta\":\"R$ 1000.00\"") == true
      assert String.contains?(result, "\"Email\":\"email@email.com\"") == true
      assert String.contains?(result, "\"Nome completo\":\"first name last name\"") == true
    end
  end

  describe "render account.json" do
    test "render account.json" do
      # do
      result =
        render_to_string(BankingApiWeb.UserView, "account.json", %{user: @user, account: @account})

      # assert
      assert String.contains?(result, "\"saldo em conta\":\"R$ 1000.00\"") == true
      assert String.contains?(result, "\"Email\":\"email@email.com\"") == true
      assert String.contains?(result, "\"Nome completo\":\"first name last name\"") == true
    end
  end

  describe "render user_auth.json" do
    test "render user_auth.json" do
      # do
      user = create_user_and_account(@user)
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)

      result =
        render_to_string(BankingApiWeb.UserView, "user_auth.json", %{user: user, token: token})

      # assert
      assert String.contains?(result, "\"saldo em conta\":\"R$ 1000.00\"") == true
      assert String.contains?(result, "\"Email\":\"email@email.com\"") == true
      assert String.contains?(result, "\"Nome completo\":\"first name last name\"") == true
    end
  end
end
