# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ivr,
  ecto_repos: [Ivr.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :ivr, IvrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VWc99RnJnL/sgDCwyLVUtS0ouWoE93bSNou5KJX0eFH81lbdKUVJYE7C6Q/qw5nM",
  render_errors: [view: IvrWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ivr.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ivr, Ivr.Auth.Guardian,
  issuer: "ivr",
  secret_key: "BpECYLrYrwiTU1SbUVJjDdTHodXYkihnPIEJGlIt7UyqDNl7M/5YFVLTyDJZT16d"

config :ivr, Ivr.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: "key-3hm2dwo3ikx01y7855te-ty3g-rvh7d1",
  domain: "notifications.twalle.com"

