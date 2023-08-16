defmodule Windog.Api.TicketTest do
  use ExUnit.Case
  doctest Windog

  test "buy/2 return :not_set_password" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    assert context = Windog.Convertor.Race.from_response(sample)

    assert {:error, :not_set_password} = Windog.Api.Ticket.buy(context, [:dummy])
  end

  test "buy/2 return :tickets_empty" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    assert context = Windog.Convertor.Race.from_response(sample)

    assert {:error, :tickets_empty} = Windog.Api.Ticket.buy(context, [])
  end
end
