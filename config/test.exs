import Config

config :nicely_bot,
  env: :test,
  ecto_repos: [NicelyBot.Repo],
  crux_gateway_token: "testtoken",
  crux_gateway_url: "nourl",
  discord_app_id: "noid",
  dicsord_invite_url: "norul",
  tenor_api_key: "noapikey"

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :nicely_bot, NicelyBot.Repo,
  username: "postgres",
  password: "postgres",
  database: "nicely_bot_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("DB_HOST") || "localhost",
  port: System.get_env("DB_PORT") || 5432,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nicely_bot, NicelyBotWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "8lrsx2eMZ7Mv2qZGUYrRBvWf9JzxEdU4VrSxcVD75HDbQcN7XXI3p8VUpjNAcIuc",
  server: false

# In test we don't send emails.
config :nicely_bot, NicelyBot.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
