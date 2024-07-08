defmodule NicelyBot.Repo do
  use Ecto.Repo,
    otp_app: :nicely_bot,
    adapter: Ecto.Adapters.Postgres
end
