# Since configuration is shared in umbrella projects, this file
# should only configure the :houston_legacy application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :houston_legacy, HoustonLegacy.Repo,
  database: "houston_test",
  hostname: "mongo"
