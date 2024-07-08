defmodule NicelyBot.DiscordEvents.Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discord_event_types" do
    field(:data, :map)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:name, :data])
    |> validate_required([:name, :data])
  end
end
