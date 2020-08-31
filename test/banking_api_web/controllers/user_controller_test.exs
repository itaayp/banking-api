defmodule BankingApiWeb.UserControllerTest do
  use BankingApiWeb.ConnCase

  alias BankingApi.Accounts
  import BankingApi.Accounts.Auth.Guardian

  @user_info "Informações do usuário"
  @cant_be_blank "can't be blank"

  @user_params %{
    email: "email@email.com",
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd"
  }

  @missing_params %{
    last_name: "last name",
    password: nil,
    password_confirmation: "pwd",
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "user signup" do
    test "signup/2 should render the created user information when the passed arguments are valid", %{conn: conn} do
      # do
      conn = post(conn, Routes.user_path(conn, :signup), user: @user_params)

      # assert
      result = json_response(conn, 201)[@user_info]

      assert "first name last name" == Map.get(result, "Nome completo")
      assert "email@email.com" == Map.get(result, "Email")
    end

    test "signup/2 should render an error message for each invalid argument", %{conn: conn} do
      # do
      conn = post(conn, Routes.user_path(conn, :signup), user: @missing_params)

      # assert
      result = json_response(conn, 422)["errors"]

      assert Map.get(result, "first_name") == [@cant_be_blank]
      assert Map.get(result, "email") == [@cant_be_blank]
      assert Map.get(result, "password") == [@cant_be_blank]
    end
  end

  describe "user signin" do
    test "signin/2 should signin an user and render the user signed information", %{conn: conn} do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_params)

      # do
      conn = post(conn, Routes.user_path(conn, :signin), email: user.email, password: user.password)

      # assert
      result = json_response(conn, 201)["data"] |> Map.get(@user_info)

      assert "first name last name" == Map.get(result, "Nome completo")
      assert "email@email.com" == Map.get(result, "Email")
    end

    test "signin/2 should not signin an user and render an unauthorized message", %{conn: conn} do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_params)

      # do
      conn = post(conn, Routes.user_path(conn, :signin), email: "invalid email", password: user.password)

      # assert
      result = json_response(conn, 422)

      assert "unauthorized" == Map.get(result, "erro")
    end
  end

  describe "show user" do
    test "show/2 should show the user information when he is previously authenticated", %{conn: conn} do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_params)
      {:ok, token, _} = encode_and_sign(user, %{}, token_type: :access)
      conn = put_req_header(conn, "authorization", "bearer: " <> token)

      # do
      conn = get(conn, Routes.user_path(conn, :show, %{"id" => user.id}))

      # assert
      result = json_response(conn, 200)[@user_info]
      assert Map.get(result, "Email") == "email@email.com"
      assert Map.get(result, "Nome completo") == "first name last name"
    end

    test "show/2 should not show the user information when he is not previously authenticated", %{conn: conn} do
      # when
      {:ok, user, _account} = Accounts.create_user(@user_params)

      # do
      conn = get(conn, Routes.user_path(conn, :show, %{"id" => user.id}))

      # assert
      result = json_response(conn, 401)
      assert Map.get(result, "error") == "unauthenticated"
    end
  end
end
