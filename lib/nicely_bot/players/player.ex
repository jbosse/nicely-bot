defmodule NicelyBot.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field(:discriminator, :string)
    field(:username, :string)
    field(:bankroll, :integer)

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:username, :discriminator, :bankroll])
    |> validate_required([:username, :discriminator, :bankroll])
  end
end

defmodule Test do
  def me do
    nil
  end
end
