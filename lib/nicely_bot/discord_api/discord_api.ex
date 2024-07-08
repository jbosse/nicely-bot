defmodule DiscordApi do

  def headers() do
    [
      {"Authorization", "Bot #{Application.fetch_env!(:nicely_bot, :crux_gateway_token)}"},
      {"Content-Type", "application/json"}
    ]
  end

  def setup_commands() do
    DiscordApi.Commands.index()
    |> DiscordApi.Commands.Flip.setup()
    |> DiscordApi.Commands.Bankroll.setup()
    |> DiscordApi.Commands.Blackjack.setup()
  end
end

defmodule DiscordApi.Commands do
  require Logger
  def url() do
    "https://discord.com/api/v8/applications/#{Application.fetch_env!(:nicely_bot, :discord_app_id)}/commands"
  end

  def index() do
    %HTTPoison.Response{status_code: 200, body: body} =
      HTTPoison.get!(url(), DiscordApi.headers())

    {:ok, json} = Jason.decode(body)
    json
  end

  def create(command) do
    {:ok, json} = command |> Jason.encode()
    HTTPoison.post!(url(), json, DiscordApi.headers())
  end

  def update(id, command) do
    {:ok, json} = command |> Jason.encode()
    HTTPoison.patch!("#{url()}/#{id}", json, DiscordApi.headers()) |> Logger.debug()
  end

  def delete(command) do
    {:ok, json} = command |> Jason.encode()
    HTTPoison.patch!(url(), json, DiscordApi.headers())
  end

  def find_command(commands, name) do
    commands |> Enum.find(fn c -> c["name"] == name end)
  end

  def setup(commands, command) do
    case find_command(commands, command.name) do
      nil -> create(command)
      _ -> nil
    end

    commands
  end

  def remove(commands, command) do
    case find_command(commands, command.name) do
      %{"id" => id} -> update(id, command)
      nil -> nil
    end

    commands
  end
end
