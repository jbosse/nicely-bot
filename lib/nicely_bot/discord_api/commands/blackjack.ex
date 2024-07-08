defmodule DiscordApi.Commands.Blackjack do
  require Logger

  alias NicelyBot.Players
  alias NicelyBot.Games.Blackjack.Deck
  alias NicelyBot.Games.Blackjack
  alias NicelyBot.Discord.Rest
  alias DiscordApi.Emoji

  @command %{
    name: "blackjack",
    description: "21 or Bust!",
    options: [
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

  def remove(commands) do
    commands |> DiscordApi.Commands.remove(@command)
  end

  def handle_event(%{
        application_id: application_id,
        channel_id: channel_id,
        id: interaction_id,
        token: token,
        data: %{
          name: "blackjack",
          options: [
            %{name: "amount", type: 4, value: amount}
          ]
        },
        member: %{
          nick: nickname,
          user: %{
            id: user_id,
            username: username,
            discriminator: discriminator
          }
        }
      }) do
    handle_intent(
      application_id,
      channel_id,
      interaction_id,
      token,
      amount,
      user_id,
      nickname,
      username,
      discriminator
    )
  end

  def handle_event(%{
        application_id: application_id,
        channel_id: channel_id,
        id: interaction_id,
        token: token,
        data: %{
          name: "blackjack",
          options: [
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
      channel_id,
      interaction_id,
      token,
      amount,
      user_id,
      nil,
      username,
      discriminator
    )
  end

  def get_user(%{member: member}), do: member.user |> Map.put(:nick, member.nick)
  def get_user(%{user: user}), do: user |> Map.put(:nick, user.username)

  def do_action(interaction, action_name) do
    Logger.info("Do Action: #{action_name}")
    user = interaction |> get_user()
    {:ok, player} = Players.find_or_create!(user.username, user.discriminator)
    IO.inspect(interaction)

    case Blackjack.game(player) do
      nil ->
        Logger.debug("no game")
        interaction |> ignore_action()

      game when game.message_id == interaction.message.id ->
        Logger.debug("this is their game")
        action(interaction, action_name)

      game ->
        Logger.debug("they have a different game")
        IO.inspect(game)
        interaction |> ignore_action()
        nil
    end
  end

  def ignore_action(interaction) do
    response = %{type: 6}
    :ok = Rest.create_interaction_response(interaction.id, interaction.token, response)
  end

  def action(interaction, "blackjack_play") do
    user = interaction |> get_user()
    {:ok, player} = Players.find_or_create!(user.username, user.discriminator)
    state = Blackjack.game(player)
    amount = state.original_bet
    message_id = state.message_id
    Blackjack.stop(player)

    state =
      Blackjack.play(
        player,
        amount,
        interaction.application_id,
        interaction.id,
        interaction.channel_id,
        interaction.token
      )

    Blackjack.update_message_id(player, message_id)

    description =
      case state do
        %{game: %{winner: :player}} ->
          Players.update_player(player, %{bankroll: player.bankroll + state.bet})
          "<@!#{user.id}> has Blackjack!"

        %{game: %{winner: :dealer}} ->
          Players.update_player(player, %{bankroll: player.bankroll - state.bet})
          "Dealer has Blackjack!"

        %{game: %{winner: :push}} ->
          "What a waste of a Blackjack."

        %{game: %{winner: nil}} ->
          {score_1, score_11} = state.game.player |> scores()

          cond do
            score_1 == score_11 -> "<@!#{user.id}> has #{score_1}."
            score_1 <= 21 && score_11 <= 21 -> "<@!#{user.id}> has #{score_1} or #{score_11}."
            score_1 > 21 && score_11 <= 21 -> "<@!#{user.id}> has #{score_11}."
            score_11 > 21 && score_1 <= 21 -> "<@!#{user.id}> has #{score_1}."
            true -> ""
          end
      end

    embed_map = embed(user.nick, user.username, description, state)

    response = %{
      type: 7,
      data: %{
        embeds: embed_map.embeds,
        components: embed_map.components
      }
    }

    :ok = Rest.create_interaction_response(interaction.id, interaction.token, response)
  end

  def action(interaction, "blackjack_stop") do
    user = interaction |> get_user()
    {:ok, player} = Players.find_or_create!(user.username, user.discriminator)
    Blackjack.stop(player)

    response = %{
      type: 7,
      data: %{
        embeds: [
          %{
            type: "rich",
            title: "Blackjack",
            description:
              "Thank you #{user.nick || user.username} for playing.\nYour bankroll is 💰#{player.bankroll}."
          }
        ],
        components: []
      }
    }

    :ok = Rest.create_interaction_response(interaction.id, interaction.token, response)
  end

  def action(interaction, action_name) do
    Logger.info("Handle Action: #{action_name}")
    user = interaction |> get_user()
    {:ok, player} = Players.find_or_create!(user.username, user.discriminator)

    action =
      case action_name do
        "blackjack_hit" -> "hit"
        "blackjack_stay" -> "stay"
        "blackjack_double_down" -> "double"
      end

    case Blackjack.game(player) do
      nil -> nil
      state -> next(action, user.nick, user.id, user.username, player, state, interaction)
    end
  end

  def handle_reaction(%{
        emoji: %{name: action},
        member:
          %{
            user: %{
              id: _user_id,
              username: username,
              discriminator: discriminator
            }
          } = member
      }) do
    Logger.info("Handle Reaction: #{action}")
    {:ok, _player} = Players.find_or_create!(username, discriminator)

    case member |> Map.fetch(:nickname) do
      {:ok, value} -> value
      :error -> nil
    end

    # case Blackjack.game(player) do
    #   nil -> nil
    #   state -> next(action, nickname, user_id, username, player, state, nil)
    # end
  end

  def handle_reaction(unknown), do: Logger.warning(unknown |> inspect())

  defp handle_intent(
         application_id,
         channel_id,
         interaction_id,
         token,
         amount,
         user_id,
         nickname,
         username,
         discriminator
       ) do
    {:ok, player} = Players.find_or_create!(username, discriminator)
    state = Blackjack.play(player, amount, application_id, interaction_id, channel_id, token)

    description =
      case state do
        %{game: %{winner: :player}} ->
          Players.update_player(player, %{bankroll: player.bankroll + state.bet})
          "<@!#{user_id}> has Blackjack!"

        %{game: %{winner: :dealer}} ->
          Players.update_player(player, %{bankroll: player.bankroll - state.bet})
          "Dealer has Blackjack!"

        %{game: %{winner: :push}} ->
          "What a waste of a Blackjack."

        %{game: %{winner: nil}} ->
          {score_1, score_11} = state.game.player |> scores()

          cond do
            score_1 == score_11 -> "<@!#{user_id}> has #{score_1}."
            score_1 <= 21 && score_11 <= 21 -> "<@!#{user_id}> has #{score_1} or #{score_11}."
            score_1 > 21 && score_11 <= 21 -> "<@!#{user_id}> has #{score_11}."
            score_11 > 21 && score_1 <= 21 -> "<@!#{user_id}> has #{score_1}."
            true -> ""
          end
      end

    embed_map = embed(nickname, username, description, state)

    response = %{
      type: 4,
      data: %{
        embeds: embed_map.embeds,
        components: embed_map.components
      }
    }

    :ok = Rest.create_interaction_response(interaction_id, token, response)
    {:ok, %{id: message_id}} = Rest.get_original_interaction_response(application_id, token)
    Blackjack.update_message_id(player, message_id)
  end

  defp component(:hit, _), do: %{type: 2, label: "Hit", style: 3, custom_id: "blackjack_hit"}
  defp component(:stay, _), do: %{type: 2, label: "Stay", style: 1, custom_id: "blackjack_stay"}

  defp component(:double, _),
    do: %{type: 2, label: "Double Down", style: 4, custom_id: "blackjack_double_down"}

  defp component(:play, state) do
    %{
      type: 2,
      label: "Play Again 💰#{state.original_bet}",
      style: 1,
      custom_id: "blackjack_play"
    }
  end

  defp component(:stop, _), do: %{type: 2, label: "Quit", style: 2, custom_id: "blackjack_stop"}

  defp component(:done, _) do
    %{type: 2, label: "✨", style: 2, custom_id: "blackjack_done", disabled: true}
  end

  defp next(action, nickname, user_id, username, player, state, interaction) do
    description =
      case action do
        "hit" -> "<@!#{user_id}> Hits..."
        "stay" -> "<@!#{user_id}> Stays..."
        "double" -> "<@!#{user_id}> Doubles Down..."
      end

    embed_map = embed(nickname, username, description, state)

    response = %{
      type: 7,
      data: %{
        embeds: embed_map.embeds,
        components: embed_map.components
      }
    }

    :ok = Rest.create_interaction_response(interaction.id, interaction.token, response)

    :timer.sleep(1000)

    new_state =
      case action do
        "hit" -> Blackjack.hit(player)
        "stay" -> Blackjack.stay(player)
        "double" -> Blackjack.double(player)
      end

    description =
      case new_state do
        %{game: %{winner: :player}} ->
          Players.update_player(player, %{bankroll: player.bankroll + new_state.bet})
          "<@!#{user_id}> Wins! 😅 You win 💰#{new_state.bet}."

        %{game: %{winner: :dealer}} ->
          Players.update_player(player, %{bankroll: player.bankroll - new_state.bet})
          "Dealer wins. 😢 You lose 💰#{new_state.bet}."

        %{game: %{winner: :push}} ->
          ":sweat_smile: It's a push. 😐 at least you keep your 💰#{new_state.bet}."

        %{game: %{winner: nil}} ->
          {score_1, score_11} = new_state.game.player |> scores()

          cond do
            score_1 == score_11 -> "<@!#{user_id}> has #{score_1}."
            score_1 <= 21 && score_11 <= 21 -> "<@!#{user_id}> has #{score_1} or #{score_11}."
            score_1 > 21 && score_11 <= 21 -> "<@!#{user_id}> has #{score_11}."
            score_11 > 21 && score_1 <= 21 -> "<@!#{user_id}> has #{score_1}."
            true -> ""
          end
      end

    response = embed(nickname, username, description, new_state)
    IO.inspect(response)
    update_message(state.token, response)
  end

  defp embed(nickname, username, description, state) do
    value = %{
      embeds: [
        %{
          type: "rich",
          title: "Blackjack",
          description: description,
          color: 0,
          fields: [
            %{
              name: "Dealer",
              value: state.game.dealer |> display_dealer(state.game)
            },
            %{
              name: "#{nickname || username}",
              value:
                state.game.player
                |> Enum.map(fn c -> Emoji.text_from_card(c) end)
                |> Enum.join(" ")
            }
          ],
          footer: %{
            text: "#{nickname || username}, select your move from the reactions below."
          }
        }
      ],
      components: [
        %{
          type: 1,
          components: state.game.options |> Enum.map(fn o -> component(o, state) end)
        }
      ]
    }

    case state.game.options |> Enum.count() do
      0 ->
        components = [
          %{
            type: 1,
            components: [component(:play, state), component(:stop, state)]
          }
        ]

        %{value | components: components}

      _ ->
        value
    end
  end

  defp update_message(token, embeds) do
    new_url =
      "https://discord.com/api/v8/webhooks/#{Application.fetch_env!(:nicely_bot, :discord_app_id)}/#{token}/messages/@original"

    HTTPoison.patch!(new_url, Jason.encode!(embeds), DiscordApi.headers()) |> Logger.info()
  end

  defp scores(hand) do
    score_1 = hand |> Enum.reduce(0, fn card, sum -> (card |> Deck.card_value(1)) + sum end)
    score_11 = hand |> Enum.reduce(0, fn card, sum -> (card |> Deck.card_value(11)) + sum end)
    {score_1, score_11}
  end

  defp display_dealer([_h | [t | []]], %{winner: nil}) do
    [Emoji.text_from_card("back"), Emoji.text_from_card(t)] |> Enum.join(" ")
  end

  defp display_dealer(hand, _) do
    hand |> Enum.map(fn c -> Emoji.text_from_card(c) end) |> Enum.join(" ")
  end
end
