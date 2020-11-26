defmodule Elementary.HoustonServerWeb.Router do
  use Elementary.HoustonServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Elementary.HoustonServerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Elementary.HoustonServerWeb.GettextPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Elementary.HoustonServerWeb do
    pipe_through :browser

    live "/", IndexLive, :index

    get "/_health", HealthController, :index

    get "/language", LanguageController, :index
    get "/language/:lang", LanguageController, :set
  end

  # Other scopes may use custom stacks.
  # scope "/api", Elementary.HoustonServerWeb do
  #   pipe_through :api
  # end
end
