defmodule Windog.Convertor.CupRaceTest do
  use ExUnit.Case
  doctest Windog

  test "from_response/1" do
    body =
      "test/samples/cup_races_2023072624.json"
      |> File.read!()
      |> Jason.decode!()

    [head | _] =
      body["races"]
      |> Enum.map(fn r ->
        schedule = Enum.find(body["schedules"], fn s -> r["scheduleId"] == s["id"] end)
        Windog.Convertor.CupRace.from_response(r, schedule, body["cup"])
      end)

    assert %Windog.Structs.Race{} = head
  end

  test "to_raw_map/1" do
    body =
      "test/samples/cup_races_2023072624.json"
      |> File.read!()
      |> Jason.decode!()

    [head | _] =
      body["races"]
      |> Enum.map(fn r ->
        schedule = Enum.find(body["schedules"], fn s -> r["scheduleId"] == s["id"] end)
        Windog.Convertor.CupRace.from_response(r, schedule, body["cup"])
      end)

    assert %{} = Windog.Convertor.CupRace.to_raw_map(head)
  end
end
