defmodule Ranking.Repo do
  use Ecto.Repo,
    otp_app: :ranking,
    adapter: Ecto.Adapters.Postgres
end
