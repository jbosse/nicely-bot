defmodule NicelyBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NicelyBotWeb.Telemetry,
      NicelyBot.Repo,
      {DNSCluster, query: Application.get_env(:nicely_bot, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NicelyBot.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NicelyBot.Finch},
      # Start a worker by calling: NicelyBot.Worker.start_link(arg)
      # {NicelyBot.Worker, arg},
      {Registry, keys: :unique, name: NicelyBot.Games.Blackjack.Registry},
      NicelyBot.Games.Blackjack.Supervisor,
      # Start to serve requests, typically the last entry
      NicelyBotWeb.Endpoint
    ]

    crux_gateway = {
      Crux.Gateway,
      {
        %{
          token: Application.fetch_env!(:nicely_bot, :crux_gateway_token),
          url: Application.fetch_env!(:nicely_bot, :crux_gateway_url),
          shard_count: 1
        },
        name: NicelyBot.Gateway
      }
    }

    children =
      case Application.get_env(:nicely_bot, :env) do
        :test -> children
        _ -> children ++ [crux_gateway, NicelyBot.DiscordConsumer]
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NicelyBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NicelyBotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
