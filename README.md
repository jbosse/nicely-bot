[![Test](https://github.com/jbosse/nicely-bot/actions/workflows/elixir.yml/badge.svg)](https://github.com/jbosse/nicely-bot/actions/workflows/elixir.yml)

# NicelyBot
Add `.env` file with the following entries set:
```
export CRUX_GATEWAY_TOKEN="mytoken"
export CRUX_GATEWAY_URL="wss://gateway.discord.gg"
export DATABASE_URL="postgres://usr:pwd@server:5432/db"
export DISCORD_APP_ID="12345"
export DISCORD_INVITE_URL="https://discord.com/api/oauth2/authorize?client_id=12345&permissions=2147821632&scope=bot%20applications.commands"
export TENOR_API_KEY="apikey"
export TENOR_APT_URL="https://g.tenor.com/v1/"
export VERSION="DEV"
```

Then run `source .env` to load the `.env` variables.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
