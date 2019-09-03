defmodule HoustonDashboard.HomepageView do
  use HoustonDashboard, :view

  def current_user?(conn), do: Plug.Conn.get_session(conn, :user_token) != nil
end
