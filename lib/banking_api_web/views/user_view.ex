defmodule BankingApiWeb.UserView do
    @moduledoc """
    Essa é a User View. Esse módulo é responsável pelo layout que é apresentado ao usuário após chamar funções referentes ao User Controller
    """

    use BankingApiWeb, :view

    def render("user.json", %{user: user}) do
        user
    end
end