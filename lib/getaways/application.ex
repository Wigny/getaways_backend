defmodule Getaways.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Getaways.Repo,
      GetawaysWeb.Endpoint,
      {Phoenix.PubSub, [name: Getaways.PubSub, adapter: Phoenix.PubSub.PG2]},
      {Absinthe.Subscription, GetawaysWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Getaways.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GetawaysWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
