defmodule NicelyBot.Games.Blackjack.Supervisor do
  use DynamicSupervisor

  alias NicelyBot.Games.Blackjack.Server

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game(player, bet, application_id, interaction_id, channel_id, token) do
    child_spec = %{
      id: Server,
      start: {Server, :start_link, [player, bet, application_id, interaction_id, channel_id, token]},
      restart: :transient
    }

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
