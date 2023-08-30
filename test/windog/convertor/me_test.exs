defmodule Windog.Convertor.MeTest do
  use ExUnit.Case
  doctest Windog

  test "from_response/1" do
    sample =
      "test/samples/me.json"
      |> File.read!()
      |> Jason.decode!()

    assert %Windog.Structs.Me{} = Windog.Convertor.Me.from_response(sample)
  end

  test "to_raw_map/1" do
    sample =
      "test/samples/me.json"
      |> File.read!()
      |> Jason.decode!()

    me = Windog.Convertor.Me.from_response(sample)

    assert %{wallet: %{}} = Windog.Convertor.Me.to_raw_map(me)
  end
end
