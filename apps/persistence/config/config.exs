use Mix.Config

config :persistence, ecto_repos: [Persistence.Repo]

import_config "#{Mix.env}.exs"
