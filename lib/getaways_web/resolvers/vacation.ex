defmodule GetawaysWeb.Resolvers.Vacation do
  alias Getaways.Vacation

  def place(_, %{slug: slug}, _) do
    {:ok, Vacation.get_place_by_slug!(slug)}
  end

  def places(_, args, _) do
    {:ok, Vacation.list_places(args)}
  end

  def create_booking(_, args, %{context: %{current_user: user}}) do
    with {:ok, booking} <- Vacation.create_booking(user, args) do
      publish_booking_change(booking)
      {:ok, booking}
    end
  end

  def cancel_booking(_, %{booking_id: booking_id}, %{context: %{current_user: user}}) do
    booking = Vacation.get_booking!(booking_id)

    if booking.user_id == user.id do
      with {:ok, booking} <- Vacation.cancel_booking(booking) do
        publish_booking_change(booking)
        {:ok, booking}
      end
    else
      {:error, message: "Hey, that's not your booking!"}
    end
  end

  def create_review(_, args, %{context: %{current_user: user}}) do
    Vacation.create_review(user, args)
  end

  defp publish_booking_change(booking) do
    Absinthe.Subscription.publish(GetawaysWeb.Endpoint, booking, booking_change: booking.place_id)
  end
end
