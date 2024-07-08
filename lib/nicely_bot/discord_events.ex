defmodule NicelyBot.DiscordEvents do
  @moduledoc """
  The DiscordEvents context.
  """

  import Ecto.Query, warn: false
  alias NicelyBot.Repo

  alias NicelyBot.DiscordEvents.Type

  @doc """
  Returns the list of discord_event_types.

  ## Examples

      iex> list_discord_event_types()
      [%Type{}, ...]

  """
  def list_discord_event_types do
    Repo.all(Type)
  end

  @doc """
  Gets a single type.

  Raises `Ecto.NoResultsError` if the Type does not exist.

  ## Examples

      iex> get_type!(123)
      %Type{}

      iex> get_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_type!(id), do: Repo.get!(Type, id)

  @doc """
  Gets a single type by name.

  Returns nil if the Type does not exist.

  ## Examples

      iex> get_type_by_name(:MESSAGE_CREATE)
      %Type{}

      iex> get_type_by_name(:NOPE)
      nil

  """
  def get_type_by_name(name), do: Repo.get_by(Type, %{name: name})

  @doc """
  Creates a type.

  ## Examples

      iex> create_type(%{field: value})
      {:ok, %Type{}}

      iex> create_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_type(attrs \\ %{}) do
    %Type{}
    |> Type.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a type.

  ## Examples

      iex> update_type(type, %{field: new_value})
      {:ok, %Type{}}

      iex> update_type(type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_type(%Type{} = type, attrs) do
    type
    |> Type.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a type.

  ## Examples

      iex> delete_type(type)
      {:ok, %Type{}}

      iex> delete_type(type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_type(%Type{} = type) do
    Repo.delete(type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking type changes.

  ## Examples

      iex> change_type(type)
      %Ecto.Changeset{data: %Type{}}

  """
  def change_type(%Type{} = type, attrs \\ %{}) do
    Type.changeset(type, attrs)
  end
end
