# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dispatch_api,
  ecto_repos: [DispatchApi.Repo]

# Configures the endpoint
config :dispatch_api, DispatchApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9xee+Xqem7Jz3VQK8udpI5UTpScWwUJP7d+LsTkjso8M4sBk+4Y6juXy5F6JocdQ",
  render_errors: [view: DispatchApi.ErrorView, accepts: ~w(json)],
  pubsub: [name: DispatchApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Config json api
config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :guardian, Guardian,
  issuer: "DispatchApi",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "7fM1iZkUhJ01Ps7/2FlNoVBXMXR9sOPswy9ngg5MHYyBK3jviEzoAoA4IgIKjZdU",
  serializer: DispatchApi.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
