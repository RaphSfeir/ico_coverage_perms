# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ico_coverage_perms,
  ecto_repos: [IcoCoveragePerms.Repo]

# Configures the endpoint
config :ico_coverage_perms, IcoCoveragePerms.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yemwldbYwGERKGxM2wF5j+KccjIKXmXq2EPz2kngJVkKZoL37RV/H5d85DLTujyM",
  render_errors: [view: IcoCoveragePerms.ErrorView, accepts: ~w(json)],
  pubsub: [name: IcoCoveragePerms.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configure Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "IcoCoveragePerms",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: "secret_key",
  serializer: IcoCoveragePerms.GuardianSerializer,
  permissions: %{
    default: [
      :read_token,
      :revoke_token,
    ],
    profile: [
      :full,
      :update,
      :read_settings,
      :update_settings
    ]
  }

# Configures Rollbax
config :rollbax,
  access_token: "099e01d77b984cd49250889afc4c96c3",
    environment: "production"

# Configures Dayron
config :ico_coverage_perms, IcoCoveragePerms.UManRepo,
  url: "http://gateway.pow.tf/user_manager/",
  headers: ["Content-Type": "application/json"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Rollbax logger backend
config :logger, 
  backends: [Rollbax.Logger]
config :logger, Rollbax.Logger,
  level: :warn

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
