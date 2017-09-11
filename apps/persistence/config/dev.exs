use Mix.Config

config :persistence, Persistence.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cookbook_dev"
