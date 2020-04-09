# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :euphoriafx,
  ecto_repos: [Euphoriafx.Repo]

# Configures the endpoint
config :euphoriafx, EuphoriafxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ltVSkyQL9Xa5KLkM+Ro20nlk2Xpy+9WOMKfFZgPz1L39LqSD1CjYqlSkLJk56eiT",
  render_errors: [view: EuphoriafxWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Euphoriafx.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "lfIPJKsx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :euphoriafx, EuphoriafxWeb.Auth.Guardian,
  issuer: "euphoriafx",
  secret_key: "kKxx5mAFt/yJ9Ht/AkWBhWMzfaaHMAMtVVGJGjtEDELv4e2yHRQ69XbA/OTBhVeo"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
