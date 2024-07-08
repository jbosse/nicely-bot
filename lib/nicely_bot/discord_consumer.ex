defmodule NicelyBot.DiscordConsumer do
  use GenStage

  require Logger

  alias NicelyBot.Discord.Rest
  alias NicelyBot.Tenor

  def start_link(args) do
    IO.puts("booting discord bot...")
    token = Application.fetch_env!(:nicely_bot, :crux_gateway_token)
    Rest.start_link(token: token, retry_limit: 3)
    GenStage.start_link(__MODULE__, args)
  end

  def init(args) do
    pids = Crux.Gateway.Connection.Producer.producers(NicelyBot.Gateway) |> Map.values()
    DiscordApi.setup_commands()
    {:consumer, args, subscribe_to: pids}
  end

  def handle_events(events, _from, state) do
    for {type, data, shard_id} <- events do
      name = type |> Atom.to_string()

      case NicelyBot.DiscordEvents.get_type_by_name(name) do
        nil -> NicelyBot.DiscordEvents.create_type(%{name: name, data: data})
        _ -> nil
      end

      handle_event(type, data, shard_id)
    end

    {:noreply, [], state}
  end

  def handle_event(
        :MESSAGE_CREATE,
        %{channel_id: channel_id, content: "-p " <> lookup},
        _shard_id
      ) do
    url = Tenor.find_gif_url(lookup)
    Rest.create_message!(channel_id, %{content: url})
  end

  def handle_event(:INTERACTION_CREATE, %{data: %{name: "flip"}} = inteaction, _shard_id) do
    DiscordApi.Commands.Flip.handle_event(inteaction)
  end

  def handle_event(:INTERACTION_CREATE, %{data: %{name: "bankroll"}} = inteaction, _shard_id) do
    DiscordApi.Commands.Bankroll.handle_event(inteaction)
  end

  def handle_event(:INTERACTION_CREATE, %{data: %{name: "blackjack"}} = inteaction, _shard_id) do
    DiscordApi.Commands.Blackjack.handle_event(inteaction)
  end

  def handle_event(:INTERACTION_CREATE, %{data: %{custom_id: action_name}} = interaction, _) do
    DiscordApi.Commands.Blackjack.do_action(interaction, action_name)
  end

  def handle_event(:MESSAGE_REACTION_ADD, reaction, _shard_id) do
    DiscordApi.Commands.Blackjack.handle_reaction(reaction)
  end

  def handle_event(type, data, _shard_id) do
    Logger.debug("Unhandled Event #{type}")
    Logger.debug(data |> inspect())
  end
end
