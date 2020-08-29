defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BankingApi.Accounts.Auth.Pipeline
  end

  # scope "/", BankingApiWeb do
  #   pipe_through :browser
  #   get "/", PageController, :index
  # end

  scope "/api/auth", BankingApiWeb do
    post "/signup", UserController, :signup
    post "/signin", UserController, :signin
  end

  scope "/api", BankingApiWeb do
    pipe_through [:api, :auth]

    get "/user", UserController, :show

    put "/operations/transfer", OperationController, :transfer
    put "/operations/withdraw", OperationController, :withdraw

    get "/transactions/all", TransactionController, :generate_entire_life_report
    get "/transactions/year/:year", TransactionController, :generate_anual_report
    get "/transactions/year/:year/month/:month", TransactionController, :generate_monthly_report
    get "/transactions/day/:day", TransactionController, :generate_daily_report
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BankingApiWeb.Telemetry
    end
  end
end
