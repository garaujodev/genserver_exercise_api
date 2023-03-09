defmodule RankingWeb.Router do
  use RankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RankingWeb do
    pipe_through :api

    get "/", UserController, :index
  end
end
