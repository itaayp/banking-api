defmodule BankingApiWeb.ChangesetViewTest do
  use BankingApiWeb.ConnCase, async: true
  alias BankingApi.Accounts.User

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @invalid_user %{
    first_name: "first name",
    last_name: "last name",
    password: "pwd",
    password_confirmation: "pwd"
  }

  describe "render error.json" do
    test "render error.json" do
      # do
      result =
        render_to_string(BankingApiWeb.ChangesetView, "error.json", %{
          changeset: User.changeset(%User{}, @invalid_user)
        })

      # assert
      assert String.contains?(result, "can't be blank") == true
    end
  end
end
