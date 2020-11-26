defmodule Elementary.HoustonServerClient.IndexTest do
  use ExUnit.Case
  use Elementary.HoustonServerClient.BrowserCase

  feature "includes a link to the language selection page", %{session: session} do
    session
    |> visit("/")
    |> assert_has(link("Language"))
  end
end
