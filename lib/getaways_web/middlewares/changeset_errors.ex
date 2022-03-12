defmodule GetawaysWeb.Middlewares.ChangesetErrors do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    %{resolution | errors: Enum.flat_map(resolution.errors, &handle_error/1)}
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&GetawaysWeb.ErrorHelpers.translate_error/1)
    |> Enum.map(fn {key, value} -> %{message: "Changeset Error!", details: %{key => value}} end)
  end

  defp handle_error(error), do: [error]
end
