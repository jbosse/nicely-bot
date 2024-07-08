defmodule NicelyBot.Games.Blackjack.Game do
  alias NicelyBot.Games.Blackjack.Deck

  def new(deck) do
    {player, deck} = {[], deck} |> deal()
    {dealer, deck} = {[], deck} |> deal()
    {player, deck} = {player, deck} |> deal()
    {dealer, deck} = {dealer, deck} |> deal()

    case player |> hand_value() do
      21 ->
        case dealer |> hand_value() do
          21 ->
            %{dealer: dealer, player: player, deck: deck, winner: :push, options: []}

          _ ->
            %{dealer: dealer, player: player, deck: deck, winner: :player, options: []}
        end

      _ ->
        case dealer |> hand_value() do
          21 ->
            %{dealer: dealer, player: player, deck: deck, winner: :dealer, options: []}

          _ ->
            %{
              dealer: dealer,
              player: player,
              deck: deck,
              winner: nil,
              options: [:hit, :stay, :double]
            }
        end
    end
  end

  def hit(game) do
    {player, deck} = {game.player, game.deck} |> deal()

    case player |> hand_value() do
      21 ->
        {dealer, deck} = {game.dealer, deck} |> deal()

        case dealer |> hand_value() do
          21 ->
            %{game | player: player, dealer: dealer, winner: :push, deck: deck, options: []}

          _ ->
            %{game | player: player, dealer: dealer, winner: :player, deck: deck, options: []}
        end

      x when x > 21 ->
        %{game | player: player, winner: :dealer, deck: deck, options: []}

      _ ->
        %{game | player: player, deck: deck, options: [:hit, :stay]}
    end
  end

  def stay(game) do
    {dealer, deck} = {game.dealer, game.deck} |> draw_to_17()

    cond do
      dealer |> hand_value() > 21 ->
        %{game | dealer: dealer, deck: deck, winner: :player, options: []}

      dealer |> hand_value() > game.player |> hand_value() ->
        %{game | dealer: dealer, deck: deck, winner: :dealer, options: []}

      dealer |> hand_value() < game.player |> hand_value() ->
        %{game | dealer: dealer, deck: deck, winner: :player, options: []}

      true ->
        %{game | dealer: dealer, deck: deck, winner: :push, options: []}
    end
  end

  def double(game) do
    {player, deck} = {game.player, game.deck} |> deal()

    case player |> hand_value() do
      21 ->
        {dealer, deck} = {game.dealer, deck} |> draw_to_17()

        case dealer |> hand_value() do
          21 ->
            %{game | player: player, dealer: dealer, winner: :push, deck: deck, options: []}

          _ ->
            %{game | player: player, dealer: dealer, winner: :player, deck: deck, options: []}
        end

      x when x > 21 ->
        %{game | player: player, winner: :dealer, deck: deck, options: []}

      _ ->
        {dealer, deck} = {game.dealer, deck} |> draw_to_17()

        cond do
          dealer |> hand_value() > 21 ->
            %{game | player: player, dealer: dealer, deck: deck, winner: :player, options: []}

          dealer |> hand_value() > player |> hand_value() ->
            %{game | player: player, dealer: dealer, deck: deck, winner: :dealer, options: []}

          dealer |> hand_value() < player |> hand_value() ->
            %{game | player: player, dealer: dealer, deck: deck, winner: :player, options: []}

          true ->
            %{game | player: player, dealer: dealer, deck: deck, winner: :push, options: []}
        end
    end
  end

  defp deal({hand, [h | t]}), do: {[h | hand |> Enum.reverse()] |> Enum.reverse(), t}

  defp hand_value(hand) do
    one = hand |> Enum.reduce(0, fn card, sum -> (card |> Deck.card_value(1)) + sum end)
    eleven = hand |> Enum.reduce(0, fn card, sum -> (card |> Deck.card_value(11)) + sum end)

    cond do
      one == 21 -> one
      eleven == 21 -> eleven
      one > 21 && eleven < 21 -> eleven
      one < 21 && eleven > 21 -> one
      one > eleven -> one
      eleven > one -> eleven
      true -> one
    end
  end

  defp draw_to_17({hand, deck}) do
    case hand |> hand_value() do
      v when v >= 17 ->
        {hand, deck}

      _ ->
        {hand, deck} |> deal() |> draw_to_17()
    end
  end
end
