defmodule HoustonDashboard.HomepageController do
  use HoustonDashboard, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
