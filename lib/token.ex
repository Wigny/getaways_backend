defmodule GetawaysWeb.Token do
  @user_salt "user auth salt"

  def sign(user) do
    data = Map.take(user, [:id])
    Phoenix.Token.sign(GetawaysWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    Phoenix.Token.verify(GetawaysWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end
end
