defmodule NicelyBot.Games.Blackjack do
  require Logger

  alias NicelyBot.Games.Blackjack.Supervisor
  alias NicelyBot.Games.Blackjack.Server

  def play(player, amount, application_id, interaction_id, channel_id, token) do
    _pid =
      case Server.game_pid(player) do
        pid when is_pid(pid) ->
          Logger.info("Game already in progress...")
          Logger.info(pid |> inspect)
          GenServer.cast(pid, {:update, interaction_id, channel_id, token})
          pid

        _ ->
          Logger.info("Starting new game...")

          {:ok, pid} =
            Supervisor.start_game(
              player,
              amount,
              application_id,
              interaction_id,
              channel_id,
              token
            )

          Logger.info(pid |> inspect)
          pid
      end

    GenServer.call(Server.via_tuple(player), :game)
  end

  def update_message_id(player, message_id) do
    case Server.game_pid(player) do
      pid when is_pid(pid) -> GenServer.cast(pid, {:update_message_id, message_id})
      _ -> nil
    end
  end

  def game(player) do
    case Server.game_pid(player) do
      pid when is_pid(pid) -> GenServer.call(pid, :game)
      _ -> nil
    end
  end

  def hit(player) do
    case Server.game_pid(player) do
      pid when is_pid(pid) -> GenServer.call(pid, :hit)
      _ -> nil
    end
  end

  def stay(player) do
    case Server.game_pid(player) do
      pid when is_pid(pid) -> GenServer.call(pid, :stay)
      _ -> nil
    end
  end

  def double(player) do
    case Server.game_pid(player) do
      pid when is_pid(pid) -> GenServer.call(pid, :double)
      _ -> nil
    end
  end

  def stop(player) do
    case Server.game_pid(player) do
      pid when is_pid(pid) -> GenServer.stop(pid, :normal)
      _ -> nil
    end
  end
end
