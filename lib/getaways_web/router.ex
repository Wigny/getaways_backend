defmodule GetawaysWeb.Router do
  use GetawaysWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug GetawaysWeb.Plugs.Context
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: GetawaysWeb.Schema

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: GetawaysWeb.Schema,
        interface: :playground
    end
  end
end
