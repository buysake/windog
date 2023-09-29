defmodule Windog.RequestHelpers.TicketMaker.V2Test do
  use ExUnit.Case
  doctest Windog
  alias Windog.RequestHelpers.TicketMaker

  test "make_nishatan/2" do
    answer =
      "test/samples/buy_v2_nishatan.json"
      |> File.read!()
      |> Jason.decode!()

    assert answer["items"] == [
             TicketMaker.V2.make_nishatan([[7], [1, 2]], 9)
           ]
  end

  test "make_sanrentan/2" do
    answer =
      "test/samples/buy_v2_sanrentan.json"
      |> File.read!()
      |> Jason.decode!()

    assert answer["items"] == [
             TicketMaker.V2.make_sanrentan([[7], [2], [1, 8]], 9)
           ]
  end
end
