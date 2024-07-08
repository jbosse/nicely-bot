defmodule NicelyBot.Repo.Migrations.CreateDiscordEventTypes do
  use Ecto.Migration

  def change do
    create table(:discord_event_types) do
      add :name, :string
      add :data, :map

      timestamps()
    end

  end
end
