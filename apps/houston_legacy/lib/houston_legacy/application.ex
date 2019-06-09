defmodule HoustonLegacy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      start_repo()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HoustonLegacy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_repo() do
    configuration = Application.get_env(:houston_legacy, HoustonLegacy.Repo)

    %{
      id: HoustonLegacy.Repo,
      start: {HoustonLegacy.Repo, :start_link, [configuration]}
    }
  end
end
