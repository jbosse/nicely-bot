defmodule NicelyBot.DiscordEventsTest do
  use NicelyBot.DataCase

  alias NicelyBot.DiscordEvents

  describe "discord_event_types" do
    alias NicelyBot.DiscordEvents.Type

    @valid_attrs %{data: %{}, name: "some name"}
    @update_attrs %{data: %{}, name: "some updated name"}
    @invalid_attrs %{data: nil, name: nil}

    def type_fixture(attrs \\ %{}) do
      {:ok, type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DiscordEvents.create_type()

      type
    end

    test "list_discord_event_types/0 returns all discord_event_types" do
      type = type_fixture()
      assert DiscordEvents.list_discord_event_types() == [type]
    end

    test "get_type!/1 returns the type with given id" do
      type = type_fixture()
      assert DiscordEvents.get_type!(type.id) == type
    end

    test "create_type/1 with valid data creates a type" do
      assert {:ok, %Type{} = type} = DiscordEvents.create_type(@valid_attrs)
      assert type.data == %{}
      assert type.name == "some name"
    end

    test "create_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DiscordEvents.create_type(@invalid_attrs)
    end

    test "update_type/2 with valid data updates the type" do
      type = type_fixture()
      assert {:ok, %Type{} = type} = DiscordEvents.update_type(type, @update_attrs)
      assert type.data == %{}
      assert type.name == "some updated name"
    end

    test "update_type/2 with invalid data returns error changeset" do
      type = type_fixture()
      assert {:error, %Ecto.Changeset{}} = DiscordEvents.update_type(type, @invalid_attrs)
      assert type == DiscordEvents.get_type!(type.id)
    end

    test "delete_type/1 deletes the type" do
      type = type_fixture()
      assert {:ok, %Type{}} = DiscordEvents.delete_type(type)
      assert_raise Ecto.NoResultsError, fn -> DiscordEvents.get_type!(type.id) end
    end

    test "change_type/1 returns a type changeset" do
      type = type_fixture()
      assert %Ecto.Changeset{} = DiscordEvents.change_type(type)
    end
  end
end
