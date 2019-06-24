defmodule HoustonDashboard.HomepageView do
  use HoustonDashboard, :view

  def current_user?(conn), do: conn.private[:current_user] != nil
end
