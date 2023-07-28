defmodule Windog.Convertor.CupTest do
  use ExUnit.Case
  doctest Windog

  test "from_response/1" do
    sample =
      "test/samples/cup_2023072624.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.Cup{} = Windog.Convertor.Cup.from_response(sample)
  end

  test "to_raw_map/1" do
    sample =
      "test/samples/cup_2023072624.json"
      |> File.read!()
      |> Jason.decode!()

    cup = %Windog.Structs.Cup{} = Windog.Convertor.Cup.from_response(sample)
    assert %{} = Windog.Convertor.Cup.to_raw_map(cup)
  end
end
