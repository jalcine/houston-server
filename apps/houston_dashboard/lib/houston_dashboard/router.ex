defmodule HoustonDashboard.Router do
  use HoustonDashboard, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HoustonDashboard do
    pipe_through :browser

    get "/", HomepageController, :index

    get "/auth/login", Auth.LoginController, :index
    post "/auth/login", Auth.LoginController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", HoustonDashboard do
  #   pipe_through :api
  # end
end
