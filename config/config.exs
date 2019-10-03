# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure the Houston library app
config :houston,
  ecto_repos: [Houston.Repo]

# Configure the HoustonDashboard app
config :houston_dashboard,
  ecto_repos: [Houston.Repo],
  generators: [context_app: :houston]

# Configures the HoustonDashboard endpoint
config :houston_dashboard, HoustonDashboard.Endpoint,
  url: [host: "localhost"],
  live_view: [signing_salt: "iKaLYZza2WFNNqLzUUdRc3cDLdazTxJI"],
  secret_key_base: "9bU3mPfnXmMfar/7/HfHyNreauJZYyHGQOGxV8F7Ud+FJpYuig+2W91a6uzWxvbB",
  render_errors: [view: HoustonDashboard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HoustonDashboard.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
