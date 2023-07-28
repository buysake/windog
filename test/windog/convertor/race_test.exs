defmodule Windog.Convertor.RaceTest do
  use ExUnit.Case
  doctest Windog

  test "from_response/1" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.RaceContext{} = Windog.Convertor.Race.from_response(sample)
  end

  test "to_raw_map/1" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    race = Windog.Convertor.Race.from_response(sample)
    assert %{} = Windog.Convertor.Race.to_raw_map(race)
  end

  test "from_raw_map/1" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    struct = Windog.Convertor.Race.from_response(sample)
    map = Windog.Convertor.Race.to_raw_map(struct)
    re_struct = Windog.Convertor.Race.from_raw_map(map)

    assert re_struct == struct
  end
end
