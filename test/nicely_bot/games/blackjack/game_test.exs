defmodule NicelyBot.Blackjack.GameTest do
  use ExUnit.Case, async: true

  alias NicelyBot.Games.Blackjack.Game

  describe "new/1" do
    test "no winner on deal" do
      deck = ~w(Ah 2c 4d Kh 5c)
      game = Game.new(deck)
      assert game.dealer == ["2c", "Kh"]
      assert game.player == ["Ah", "4d"]
      assert game.deck == ["5c"]
      assert game.winner == nil
      assert game.options == [:hit, :stay, :double]
    end

    test "player wins on deal" do
      deck = ~w(Ah 2c Jd Kh 5c)
      game = Game.new(deck)
      assert game.dealer == ["2c", "Kh"]
      assert game.player == ["Ah", "Jd"]
      assert game.deck == ["5c"]
      assert game.winner == :player
      assert game.options == []
    end

    test "dealer wins on deal" do
      deck = ~w(Ah Ac 4d Kh 5c)
      game = Game.new(deck)
      assert game.dealer == ["Ac", "Kh"]
      assert game.player == ["Ah", "4d"]
      assert game.deck == ["5c"]
      assert game.winner == :dealer
      assert game.options == []
    end

    test "push on deal" do
      deck = ~w(Ah Ac Jd Kh 5c)
      game = Game.new(deck)
      assert game.dealer == ["Ac", "Kh"]
      assert game.player == ["Ah", "Jd"]
      assert game.deck == ["5c"]
      assert game.winner == :push
      assert game.options == []
    end

    test "player gets a pair" do
    end
  end

  describe "hit/1" do
    test "deal another card - player still is under 21" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["5c", "7c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.hit(game)

      assert result.dealer == ["2c", "Kh"]
      assert result.player == ["Ah", "4d", "5c"]
      assert result.deck == ["7c"]
      assert result.winner == nil
      assert result.options == [:hit, :stay]
    end

    test "deal another card - player gets 21, dealer loses" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["6c", "5c", "4h"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.hit(game)

      assert result.dealer == ["2c", "Kh", "5c"]
      assert result.player == ["Ah", "4d", "6c"]
      assert result.deck == ["4h"]
      assert result.winner == :player
      assert result.options == []
    end

    test "deal another card - player gets 21, dealer draws" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["6c", "9c", "4h"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.hit(game)

      assert result.dealer == ["2c", "Kh", "9c"]
      assert result.player == ["Ah", "4d", "6c"]
      assert result.deck == ["4h"]
      assert result.winner == :push
      assert result.options == []
    end

    test "deal another card - player over 21" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Th", "4d"],
        deck: ["9c", "7c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.hit(game)

      assert result.dealer == ["2c", "Kh"]
      assert result.player == ["Th", "4d", "9c"]
      assert result.deck == ["7c"]
      assert result.winner == :dealer
      assert result.options == []
    end
  end

  describe "stay/1" do
    test "dealer already beats player" do
      game = %{
        dealer: ["8c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["9c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.stay(game)

      assert result.dealer == ["8c", "Kh"]
      assert result.player == ["Ah", "4d"]
      assert result.deck == ["9c"]
      assert result.winner == :dealer
      assert result.options == []
    end

    test "dealer hits until 17 player wins" do
      game = %{
        dealer: ["2c", "6h"],
        player: ["Th", "Td"],
        deck: ["2h", "3h", "4h", "9c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.stay(game)

      assert result.dealer == ["2c", "6h", "2h", "3h", "4h"]
      assert result.player == ["Th", "Td"]
      assert result.deck == ["9c"]
      assert result.winner == :player
      assert result.options == []
    end

    test "dealer hits until 17 player loses" do
      game = %{
        dealer: ["2c", "6h"],
        player: ["Th", "2d"],
        deck: ["2h", "3h", "8h", "9c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.stay(game)

      assert result.dealer == ["2c", "6h", "2h", "3h", "8h"]
      assert result.player == ["Th", "2d"]
      assert result.deck == ["9c"]
      assert result.winner == :dealer
      assert result.options == []
    end

    test "dealer hits until 17 draw" do
      game = %{
        dealer: ["2c", "6h"],
        player: ["Th", "Td"],
        deck: ["2h", "3h", "7h", "9c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.stay(game)

      assert result.dealer == ["2c", "6h", "2h", "3h", "7h"]
      assert result.player == ["Th", "Td"]
      assert result.deck == ["9c"]
      assert result.winner == :push
      assert result.options == []
    end

    test "dealer busts" do
      game = %{
        dealer: ["2c", "6h"],
        player: ["Th", "2d"],
        deck: ["2h", "3h", "9h", "9c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.stay(game)

      assert result.dealer == ["2c", "6h", "2h", "3h", "9h"]
      assert result.player == ["Th", "2d"]
      assert result.deck == ["9c"]
      assert result.winner == :player
      assert result.options == []
    end
  end

  describe "double/1" do
    test "deal another card - player still is under 21 dealer loses" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["5c", "7c", "8s"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.double(game)

      assert result.dealer == ["2c", "Kh", "7c"]
      assert result.player == ["Ah", "4d", "5c"]
      assert result.deck == ["8s"]
      assert result.winner == :player
      assert result.options == []
    end

    test "deal another card - player still is under 21 dealer wins" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["5c", "9c", "8s"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.double(game)

      assert result.dealer == ["2c", "Kh", "9c"]
      assert result.player == ["Ah", "4d", "5c"]
      assert result.deck == ["8s"]
      assert result.winner == :dealer
      assert result.options == []
    end

    test "deal another card - player still is under 21 push" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["5c", "8c", "8s"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.double(game)

      assert result.dealer == ["2c", "Kh", "8c"]
      assert result.player == ["Ah", "4d", "5c"]
      assert result.deck == ["8s"]
      assert result.winner == :push
      assert result.options == []
    end

    test "deal another card - player gets 21, dealer loses" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["6c", "8d", "4h"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.double(game)

      assert result.dealer == ["2c", "Kh", "8d"]
      assert result.player == ["Ah", "4d", "6c"]
      assert result.deck == ["4h"]
      assert result.winner == :player
      assert result.options == []
    end

    test "deal another card - player gets 21, dealer draws" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Ah", "4d"],
        deck: ["6c", "9c", "4h"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.double(game)

      assert result.dealer == ["2c", "Kh", "9c"]
      assert result.player == ["Ah", "4d", "6c"]
      assert result.deck == ["4h"]
      assert result.winner == :push
      assert result.options == []
    end

    test "deal another card - player over 21" do
      game = %{
        dealer: ["2c", "Kh"],
        player: ["Th", "4d"],
        deck: ["9c", "7c"],
        winner: nil,
        options: [:hit, :stay]
      }

      result = Game.double(game)

      assert result.dealer == ["2c", "Kh"]
      assert result.player == ["Th", "4d", "9c"]
      assert result.deck == ["7c"]
      assert result.winner == :dealer
      assert result.options == []
    end
  end
end
