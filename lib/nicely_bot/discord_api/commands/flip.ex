defmodule DiscordApi.Commands.Flip do
  alias NicelyBot.Discord.Rest
  alias NicelyBot.CoinFlip

  @command %{
    name: "flip",
    description: "Flip a coin!",
    options: [
      %{
        name: "side",
        description: "heads or tails",
        type: 3,
        required: true,
        choices: [
          %{name: "heads", value: "heads"},
          %{name: "tails", value: "tails"}
        ]
      },
      %{
        name: "amount",
        description: "how much to bet",
        type: 4,
        required: true
      }
    ]
  }

  def setup(commands) do
    commands |> DiscordApi.Commands.setup(@command)
  end

  def handle_event(%{
        application_id: application_id,
        channel_id: _channel_id,
        id: interaction_id,
        token: token,
        data: %{
          name: "flip",
          options: [
            %{name: "side", type: 3, value: side},
            %{name: "amount", type: 4, value: amount}
          ]
        },
        member: %{
          user: %{
            id: user_id,
            username: username,
            discriminator: discriminator
          }
        }
      }) do
    handle_intent(
      application_id,
      interaction_id,
      token,
      side,
      amount,
      user_id,
      username,
      discriminator
    )
  end

  def handle_event(%{
        application_id: application_id,
        channel_id: _channel_id,
        id: interaction_id,
        token: token,
        data: %{
          name: "flip",
          options: [
            %{name: "side", type: 3, value: side},
            %{name: "amount", type: 4, value: amount}
          ]
        },
        user: %{
          id: user_id,
          username: username,
          discriminator: discriminator
        }
      }) do
    handle_intent(
      application_id,
      interaction_id,
      token,
      side,
      amount,
      user_id,
      username,
      discriminator
    )
  end

  defp handle_intent(
         _application_id,
         interaction_id,
         token,
         _side,
         amount,
         user_id,
         _username,
         _discriminator
       )
       when amount < 1 or amount > 1000 do
    message = "<@!#{user_id}> you may only bet amounts of 1-1000"

    response = %{
      type: 4,
      data: %{embeds: [%{type: "rich", description: message, color: 10_038_562}]}
    }

    Rest.create_interaction_response(interaction_id, token, response)
  end

  defp handle_intent(
         application_id,
         interaction_id,
         token,
         side,
         amount,
         user_id,
         _username,
         "5390"
       ) do
    response1 = %{
      type: 4,
      data: %{
        embeds: [
          %{
            type: "rich",
            description: "<@!#{user_id}> calls #{side}.\n:coin: flipping...",
            color: 0
          }
        ]
      }
    }

    Rest.create_interaction_response(interaction_id, token, response1)
    :timer.sleep(1000)
    message = "WAT? The coin laded on its side! You keep your 💰#{amount}."

    response2 = %{
      embeds: [
        %{type: "rich", description: "<@!#{user_id}> calls #{side}.\n#{message}", color: 0}
      ]
    }

    Rest.modify_original_interaction_response(application_id, token, response2)
  end

  defp handle_intent(
         application_id,
         interaction_id,
         token,
         side,
         amount,
         user_id,
         username,
         discriminator
       ) do
    response1 = %{
      type: 4,
      data: %{
        embeds: [
          %{
            type: "rich",
            description: "<@!#{user_id}> calls #{side}.\n:coin: flipping...",
            color: 0
          }
        ]
      }
    }

    Rest.create_interaction_response(interaction_id, token, response1)
    :timer.sleep(1000)
    {result, message} = CoinFlip.play(username, discriminator, side, amount)

    color =
      case result do
        :win -> 1_146_986
        :lose -> 10_038_562
      end

    response2 = %{
      embeds: [
        %{type: "rich", description: "<@!#{user_id}> calls #{side}.\n#{message}", color: color}
      ]
    }

    Rest.modify_original_interaction_response(application_id, token, response2)
  end
end
