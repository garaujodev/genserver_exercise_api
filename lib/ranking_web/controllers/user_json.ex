defmodule RankingWeb.UserJSON do
  alias Ranking.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{data: %{timestamp: timestamp, users: users}}) do
    %{timestamp: timestamp, users: for(user <- users, do: data(user))}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      points: user.points
    }
  end
end
