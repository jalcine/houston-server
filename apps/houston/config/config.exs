# Since configuration is shared in umbrella projects, this file
# should only configure the :houston application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :houston,
  ecto_repos: [Houston.Repo]

import_config "#{Mix.env()}.exs"
