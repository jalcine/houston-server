defmodule Elementary.HoustonServerWeb.LanguageView do
  use Elementary.HoustonServerWeb, :view

  def available_languages() do
    Elementary.HoustonServerWeb.Gettext.known_languages()
  end
end
