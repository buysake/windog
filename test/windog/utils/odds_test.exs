defmodule Windog.Utils.OddsTest do
  use ExUnit.Case
  doctest Windog

  test "filter_odds/5 with sanrentan" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrentan, ["1"], ["2"], ["3"])
             |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrentan, ["1"], ["2", "3"], ["2", "3"])
             |> Enum.count()

    assert 4 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrentan, ["1", "2"], ["1", "2", "3"], [
               "1",
               "2",
               "3"
             ])
             |> Enum.count()
  end

  test "filter_odds/5 with sanrenpuku" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrenpuku, ["1"], ["2"], ["3"])
             |> Enum.count()

    assert 1 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrenpuku, ["1"], ["2", "3"], ["2", "3"])
             |> Enum.count()

    assert 1 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrenpuku, ["1", "2"], ["1", "2", "3"], [
               "1",
               "2",
               "3"
             ])
             |> Enum.count()

    assert 3 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:sanrenpuku, ["1"], ["2", "3"], ["1", "2", "3", "4"])
             |> Enum.count()
  end

  test "filter_odds/4 with nishatan" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 == odds |> Windog.Utils.Odds.filter_odds(:nishatan, ["1"], ["2"]) |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:nishatan, ["1"], ["2", "3"])
             |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:nishatan, ["2", "3"], ["2", "3"])
             |> Enum.count()
  end

  test "filter_odds/4 with nishafuku" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:nishafuku, ["1"], ["2"])
             |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:nishafuku, ["1"], ["2", "3"])
             |> Enum.count()

    assert 1 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:nishafuku, ["2", "3"], ["2", "3"])
             |> Enum.count()

    assert 6 ==
             odds
             |> Windog.Utils.Odds.filter_odds(:nishafuku, ["1"], [
               "1",
               "2",
               "3",
               "4",
               "5",
               "6",
               "7"
             ])
             |> Enum.count()
  end

  test "allocation/2" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    sample =
      odds
      |> Windog.Utils.Odds.filter_odds(:nishafuku, ["1"], ["1", "2", "3", "4", "5", "6", "7"])

    assert [100, 100, 100, 100, 100, 100] ==
             sample |> Windog.Utils.Odds.allocation(600) |> Enum.map(fn {_, a} -> a end)

    assert [200, 100, 100, 400, 100, 100] ==
             sample |> Windog.Utils.Odds.allocation(1000) |> Enum.map(fn {_, a} -> a end)

    assert [0, 0, 0, 0, 0, 0] ==
             sample |> Windog.Utils.Odds.allocation(0) |> Enum.map(fn {_, a} -> a end)
  end
end
