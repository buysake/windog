defmodule Windog.Convertor.RaceTest do
  use ExUnit.Case
  doctest Windog

  test "from_response/1" do
    sample =
      "test/samples/race_2023042046_2_3.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.RaceContext{
             is_finish: true,
             has_absent_player: false,
             has_accident: false
           } = Windog.Convertor.Race.from_response(sample)
  end

  test "from_response/1 with has_absent_player = true" do
    sample =
      "test/samples/race_2023080283_2_2.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.RaceContext{
             is_finish: true,
             has_absent_player: true,
             has_accident: true
           } = Windog.Convertor.Race.from_response(sample)
  end

  test "from_response/1 with has_accident = true" do
    sample =
      "test/samples/race_2023080445_1_5.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.RaceContext{
             is_finish: true,
             has_absent_player: false,
             has_accident: true
           } = Windog.Convertor.Race.from_response(sample)
  end

  test "from_response/1 with @margin_overtime" do
    sample =
      "test/samples/race_2023061356_1_8.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.RaceContext{
             results: results
           } = Windog.Convertor.Race.from_response(sample)

    assert [nil, _, _, _, _, _, _, _, 99.9] =
             Enum.map(results, & &1.margin_by_top)

    assert [nil, _, _, _, _, _, _, _, 99.9] =
             Enum.map(results, & &1.margin)
  end

  test "from_response/1 with equal order" do
    sample =
      "test/samples/race_2022111284_3_5.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.RaceContext{
             results: results
           } = Windog.Convertor.Race.from_response(sample)

    assert [_, _, _, a, b, c, _] =
             Enum.map(results, & &1.margin_by_top)

    assert [a, b, c] |> Enum.uniq() |> Enum.count() == 1

    assert [_, _, _, a, b, c, _] =
             Enum.map(results, & &1.margin)

    assert [a, b, c] |> Enum.uniq() |> Enum.count() == 1
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
