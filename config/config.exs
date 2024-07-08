# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :nicely_bot,
  ecto_repos: [NicelyBot.Repo],
  generators: [timestamp_type: :utc_datetime],
  version: System.get_env("VERSION") || "#{Mix.env()}",
  crux_gateway_token: System.get_env("CRUX_GATEWAY_TOKEN") || "crux_gateway_token",
  crux_gateway_url: System.get_env("CRUX_GATEWAY_URL") || "crux_gateway_url",
  discord_app_id: System.get_env("DISCORD_APP_ID") || "discord_app_id",
  dicsord_invite_url: System.get_env("DISCORD_INVITE_URL") || "discord_invite_url",
  tenor_api_key: System.get_env("TENOR_API_KEY") || "tenor_api_key"

# Configures the endpoint
config :nicely_bot, NicelyBotWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: NicelyBotWeb.ErrorHTML, json: NicelyBotWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: NicelyBot.PubSub,
  live_view: [signing_salt: "I5eXyOHh"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :nicely_bot, NicelyBot.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  nicely_bot: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  nicely_bot: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
