defmodule NicelyBot.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :username, :string
      add :discriminator, :string
      add :bankroll, :integer
      timestamps()
    end

  end
end
