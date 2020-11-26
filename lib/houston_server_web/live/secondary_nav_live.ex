defmodule Elementary.HoustonServerWeb.SecondaryNavLive do
  @moduledoc false

  use Elementary.HoustonServerWeb, :live_view

  alias Elementary.HoustonServerWeb.Gettext, as: Gtext

  @impl true
  def mount(_params, session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Elementary.HoustonServerWeb.LayoutView.render("secondary-nav.html", assigns)
  end
end
