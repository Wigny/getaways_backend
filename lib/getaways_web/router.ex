defmodule GetawaysWeb.Router do
  use GetawaysWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GetawaysWeb do
    pipe_through :api
  end
end
