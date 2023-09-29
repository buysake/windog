defmodule Windog.RequestHelpers.TicketMaker.V2Test do
  use ExUnit.Case
  doctest Windog
  alias Windog.RequestHelpers.TicketMaker

  test "make_nishatan/2" do
    race =
      "test/samples/race_2023092845_3_11.json"
      |> File.read!()
      |> Jason.decode!()
      |> Windog.Convertor.Race.from_response()

    answer =
      "test/samples/buy_v2_nishatan.json"
      |> File.read!()
      |> Jason.decode!()

    assert answer["items"] == [
             TicketMaker.V2.make_nishatan([[7], [1, 2]], race)
           ]
  end

  test "make_sanrentan/2" do
    race =
      "test/samples/race_2023092845_3_11.json"
      |> File.read!()
      |> Jason.decode!()
      |> Windog.Convertor.Race.from_response()

    answer =
      "test/samples/buy_v2_sanrentan.json"
      |> File.read!()
      |> Jason.decode!()

    assert answer["items"] == [
             TicketMaker.V2.make_sanrentan([[7], [2], [1, 8]], race)
           ]
  end

  test "set_unit/3" do
    race =
      "test/samples/race_2023092845_3_11.json"
      |> File.read!()
      |> Jason.decode!()
      |> Windog.Convertor.Race.from_response()

    default = TicketMaker.V2.make_sanrentan([[7], [2], [1, 8]], race)

    replaced = TicketMaker.V2.set_unit(default, [7, 2, 1], 10)

    total = replaced["points"] |> Enum.map(fn %{"unitQuantity" => q} -> q end) |> Enum.sum()

    assert total == 11
  end
end
