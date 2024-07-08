defmodule NicelyBot.Games.Blackjack.Server do
  use GenServer

  alias NicelyBot.Games.Blackjack.Deck
  alias NicelyBot.Games.Blackjack.Game

  require Logger

  @timeout :timer.hours(2)

  def start_link(player, bet, application_id, interaction_id, channel_id, token) do
    GenServer.start_link(__MODULE__, {bet, application_id, interaction_id, channel_id, token},
      name: via_tuple(player)
    )
  end

  def via_tuple(player) do
    {:via, Registry, {NicelyBot.Games.Blackjack.Registry, player.id}}
  end

  def game_pid(player) do
    player
    |> via_tuple()
    |> GenServer.whereis()
  end

  def init({bet, application_id, interaction_id, channel_id, token}) do
    game = Deck.new() |> Game.new()

    state = %{
      application_id: application_id,
      interaction_id: interaction_id,
      channel_id: channel_id,
      message_id: nil,
      token: token,
      original_bet: bet,
      bet: bet,
      game: game
    }

    {:ok, state, @timeout}
  end

  def handle_call(:game, _from, state) do
    {:reply, state, state, @timeout}
  end

  def handle_call(:hit, _from, state) do
    game = Game.hit(state.game)
    state = %{state | game: game}
    {:reply, state, state, @timeout}
  end

  def handle_call(:stay, _from, state) do
    game = Game.stay(state.game)
    state = %{state | game: game}
    {:reply, state, state, @timeout}
  end

  def handle_call(:double, _from, state) do
    game = Game.double(state.game)
    state = %{state | game: game, bet: state.bet * 2}
    {:reply, state, state, @timeout}
  end

  def handle_call(type, _from, state) do
    Logger.warning("Unhandled call #{type}")
    {:reply, nil, state, @timeout}
  end

  def handle_cast({:update, interaction_id, channel_id, token}, state) do
    {:noreply, %{state | interaction_id: interaction_id, channel_id: channel_id, token: token}}
  end

  def handle_cast({:update_message_id, message_id}, state) do
    {:noreply, %{state | message_id: message_id}}
  end
end
