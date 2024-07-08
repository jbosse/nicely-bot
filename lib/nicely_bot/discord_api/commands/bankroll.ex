defmodule DiscordApi.Commands.Bankroll do
  alias NicelyBot.Discord.Rest
  alias NicelyBot.Players

  @command %{
    name: "bankroll",
    description: "Check your ballance."
  }

  def setup(commands) do
    commands |> DiscordApi.Commands.setup(@command)
  end

  def handle_event(%{
        id: interaction_id,
        token: token,
        data: %{
          name: "bankroll"
        },
        member: %{
          user: %{
            id: user_id,
            username: username,
            discriminator: discriminator
          }
        }
      }) do
    handle_intent(interaction_id, token, user_id, username, discriminator)
  end

  def handle_event(%{
        id: interaction_id,
        token: token,
        data: %{
          name: "bankroll"
        },
        user: %{
          id: user_id,
          username: username,
          discriminator: discriminator
        }
      }) do
    handle_intent(interaction_id, token, user_id, username, discriminator)
  end

  defp handle_intent(interaction_id, token, user_id, username, discriminator) do
    {:ok, player} = Players.find_or_create!(username, discriminator)
    message = "<@!#{user_id}>, you have a bankroll of 💰#{player.bankroll}."

    response = %{
      type: 4,
      data: %{
        embeds: [
          %{type: "rich", description: message, color: 1_146_986}
        ]
      }
    }

    Rest.create_interaction_response(interaction_id, token, response)
  end
end
