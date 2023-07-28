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
end
