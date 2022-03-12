defmodule GetawaysWeb.Resolvers.Accounts do
  alias Getaways.Accounts

  def signin(_, %{username: username, password: password}, _) do
    case Accounts.authenticate(username, password) do
      {:ok, user} ->
        token = GetawaysWeb.Token.sign(user)
        {:ok, %{user: user, token: token}}

      :error ->
        {:error, "Whoops, invalid credentials!"}
    end
  end

  def signup(_, args, _) do
    with {:ok, user} <- Accounts.create_user(args) do
      token = GetawaysWeb.Token.sign(user)
      {:ok, %{user: user, token: token}}
    end
  end
end
