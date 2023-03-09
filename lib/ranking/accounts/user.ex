defmodule Ranking.Accounts.User do
  @moduledoc """
  User schema 
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_inclusion(:points, 0..100)
  end
end
