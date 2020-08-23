 defmodule BankingApiWeb.UserController do
    @moduledoc """
    Esse é o Controller do User. Este módulo resonsável por gerenciar todas as ações relacionadas ao usuário
    """

    use BankingApiWeb, :controller

    @doc """
    A função `signup` é responsável por cadastrar um novo usuário no sistema
    """
    def signup(conn, %{"user" => user}) do
        conn
        |> put_status(:created)
        |> render("user.json", %{user: user})
    end
end