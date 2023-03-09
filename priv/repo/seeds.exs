# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ranking.Repo.insert!(%Ranking.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

datetime = 
  NaiveDateTime.utc_now
  |> NaiveDateTime.truncate(:second)

data = Enum.map(1..1_000_000, fn _val -> %{inserted_at: datetime, updated_at: datetime} end)

list_of_chunks = Enum.chunk_every(data, 1_000)

Enum.each list_of_chunks, fn rows ->
  Ranking.Repo.insert_all(Ranking.Accounts.User, rows)
end
