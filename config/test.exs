use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ivr, IvrWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ivr, Ivr.Repo,
  username: "twalle",
  password: "Twalle@123@kadosh",
  database: "ivr_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
