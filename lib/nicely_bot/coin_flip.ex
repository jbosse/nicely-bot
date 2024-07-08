defmodule NicelyBot.CoinFlip do
  alias NicelyBot.Players

  def flip(side, bet) do
    case {side, Enum.random(0..1)} do
      {"heads", 0} -> {"It's heads! 😅 You win 💰#{bet}.", 0 + bet, :win}
      {"tails", 0} -> {"It's heads. 😢 You lose 💰#{bet}.", 0 - bet, :lose}
      {"heads", 1} -> {"It's tails. 😢 You lose 💰#{bet}.", 0 - bet, :lose}
      {"tails", 1} -> {"It's tails! 😅 You win 💰#{bet}.", 0 + bet, :win}
    end
  end

  def play(username, discriminator, command_string) do
    [side, amount] = command_string |> String.split()
    bet = amount |> String.to_integer()
    {:ok, player} = Players.find_or_create!(username, discriminator)
    {message, winnings, _} = flip(side, bet)
    Players.update_player(player, %{bankroll: player.bankroll + winnings})
    message
  end

  def play(username, discriminator, side, amount) do
    {:ok, player} = Players.find_or_create!(username, discriminator)
    {message, winnings, result} = flip(side, amount)
    Players.update_player(player, %{bankroll: player.bankroll + winnings})
    {result, message}
  end
end
