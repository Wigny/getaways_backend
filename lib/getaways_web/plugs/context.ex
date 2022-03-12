defmodule GetawaysWeb.Plugs.Context do
  @behaviour Plug

  import Plug.Conn

  alias Getaways.Accounts
  alias GetawaysWeb.Token

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token),
         %Accounts.User{} = user <- Accounts.get_user(data.id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
