defmodule RankingWeb.UserController do
  use RankingWeb, :controller

  alias Ranking.Worker

  def index(conn, _params) do
    data = Worker.get()

    render(conn, :index, data: data)
  end
end
