defmodule Ranking.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ranking.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        points: 42
      })
      |> Ranking.Accounts.create_user()

    user
  end
end
