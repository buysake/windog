defmodule Windog.UtilsTest do
  use ExUnit.Case
  doctest Windog

  test "build_race_url/1" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    struct = Windog.Convertor.Race.from_response(sample)
    url = Windog.Utils.build_race_url(struct)

    assert url ==
             "https://www.winticket.jp/keirin/#{struct.venue.slug}/racecard/#{struct.cup.id}/#{struct.race.day_index}/#{struct.race.r}"
  end

  test "filter_odds/5 with sanrentan" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 == odds |> Windog.Utils.filter_odds(:sanrentan, ["1"], ["2"], ["3"]) |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.filter_odds(:sanrentan, ["1"], ["2", "3"], ["2", "3"])
             |> Enum.count()

    assert 4 ==
             odds
             |> Windog.Utils.filter_odds(:sanrentan, ["1", "2"], ["1", "2", "3"], ["1", "2", "3"])
             |> Enum.count()
  end

  test "filter_odds/5 with sanrenpuku" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 == odds |> Windog.Utils.filter_odds(:sanrenpuku, ["1"], ["2"], ["3"]) |> Enum.count()

    assert 1 ==
             odds
             |> Windog.Utils.filter_odds(:sanrenpuku, ["1"], ["2", "3"], ["2", "3"])
             |> Enum.count()

    assert 1 ==
             odds
             |> Windog.Utils.filter_odds(:sanrenpuku, ["1", "2"], ["1", "2", "3"], ["1", "2", "3"])
             |> Enum.count()

    assert 3 ==
             odds
             |> Windog.Utils.filter_odds(:sanrenpuku, ["1"], ["2", "3"], ["1", "2", "3", "4"])
             |> Enum.count()
  end

  test "filter_odds/4 with nishatan" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    odds = Windog.Convertor.Race.from_response(sample).odds

    assert 1 == odds |> Windog.Utils.filter_odds(:nishatan, ["1"], ["2"]) |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.filter_odds(:nishatan, ["1"], ["2", "3"])
             |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.filter_odds(:nishatan, ["2", "3"], ["2", "3"])
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
             |> Windog.Utils.filter_odds(:nishafuku, ["1"], ["2"])
             |> Enum.count()

    assert 2 ==
             odds
             |> Windog.Utils.filter_odds(:nishafuku, ["1"], ["2", "3"])
             |> Enum.count()

    assert 1 ==
             odds
             |> Windog.Utils.filter_odds(:nishafuku, ["2", "3"], ["2", "3"])
             |> Enum.count()

    assert 6 ==
             odds
             |> Windog.Utils.filter_odds(:nishafuku, ["1"], ["1", "2", "3", "4", "5", "6", "7"])
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
      |> Windog.Utils.filter_odds(:nishafuku, ["1"], ["1", "2", "3", "4", "5", "6", "7"])

    assert [100, 100, 100, 100, 100, 100] ==
             sample |> Windog.Utils.allocation(600) |> Enum.map(fn {_, a} -> a end)

    IO.inspect(sample)

    assert [200, 100, 100, 400, 100, 100] ==
             sample |> Windog.Utils.allocation(1000) |> Enum.map(fn {_, a} -> a end)

    assert [0, 0, 0, 0, 0, 0] ==
             sample |> Windog.Utils.allocation(0) |> Enum.map(fn {_, a} -> a end)
  end
end
