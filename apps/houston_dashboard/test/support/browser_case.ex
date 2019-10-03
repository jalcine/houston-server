defmodule HoustonDashboard.BrowserCase do
  @moduledoc """
  This module defines a test using `Hound` to test in a browser session.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      use Hound.Helpers
      use Houston.Factories

      alias HoustonDashboard.Router.Helpers, as: Routes

      import HoustonDashboard.BrowserCase

      # The default endpoint for testing
      @endpoint HoustonDashboard.Endpoint

      hound_session()
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Houston.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Houston.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  Iterates over the given values and submits the form.

  ## Examples

    iex> submit_form(".login", [username: "admin", password: "password"])
  """
  def submit_form(selector, values) do
    form = Hound.Helpers.Page.find_element(:css, selector)

    Enum.each(values, fn {key, value} ->
      element = Hound.Helpers.Page.find_within_element(form, :css, key)
      Hound.Helpers.Element.fill_field(element, value)
    end)

    Hound.Helpers.Element.submit_element(form)
  end
end
