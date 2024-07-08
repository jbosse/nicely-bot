defmodule NicelyBot.Games.Blackjack.Deck do
  def new() do
    ranks = ~w(A K Q J T 9 8 7 6 5 4 3 2)
    suits = ~w(s h d c)

    fresh =
      for rank <- ranks, suit <- suits do
        "#{rank}#{suit}"
      end

    fresh
    |> Enum.shuffle()
    |> Enum.shuffle()
    |> Enum.shuffle()
    |> Enum.shuffle()
    |> Enum.shuffle()
  end

  def card_value(card, ace_is \\ 11) do
    value =
      card
      |> card_rank()
      |> rank_value()

    case value do
      11 -> ace_is
      _ -> value
    end
  end

  def card_rank(card) do
    String.at(card, 0)
  end

  def card_suit(card) do
    String.at(card, 1)
  end

  def display(card) do
    rank = card_rank(card)
    suit = card_suit(card)
    "[**#{rank}**#{suit}]"
  end

  defp rank_value("A"), do: 11
  defp rank_value("K"), do: 10
  defp rank_value("Q"), do: 10
  defp rank_value("J"), do: 10
  defp rank_value("T"), do: 10
  defp rank_value("9"), do: 9
  defp rank_value("8"), do: 8
  defp rank_value("7"), do: 7
  defp rank_value("6"), do: 6
  defp rank_value("5"), do: 5
  defp rank_value("4"), do: 4
  defp rank_value("3"), do: 3
  defp rank_value("2"), do: 2
end
