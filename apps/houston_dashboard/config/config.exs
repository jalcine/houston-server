# Since configuration is shared in umbrella projects, this file
# should only configure the :houston_dashboard application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :houston_dashboard,
  ecto_repos: [Houston.Repo],
  generators: [context_app: :houston]

# Configures the endpoint
config :houston_dashboard, HoustonDashboard.Endpoint,
  url: [host: "localhost"],
  live_view: [signing_salt: "iKaLYZza2WFNNqLzUUdRc3cDLdazTxJI"],
  secret_key_base: "9bU3mPfnXmMfar/7/HfHyNreauJZYyHGQOGxV8F7Ud+FJpYuig+2W91a6uzWxvbB",
  render_errors: [view: HoustonDashboard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HoustonDashboard.PubSub, adapter: Phoenix.PubSub.PG2]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
