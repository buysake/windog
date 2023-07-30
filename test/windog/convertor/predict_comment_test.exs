defmodule Windog.Convertor.PredictCommentTest do
  use ExUnit.Case
  doctest Windog

  test "from_response/1" do
    sample =
      "test/samples/predict_comments_2023072822_3_1.json"
      |> File.read!()
      |> Jason.decode!()

    [head | _] =
      sample["comments"]
      |> Enum.map(fn c ->
        tipster = sample["tipsters"] |> Enum.find(fn t -> t["id"] == c["tipsterId"] end)

        Windog.Convertor.PredictComment.from_response(c, tipster,
          cup_id: "2023072822",
          day_index: 3,
          r: 1
        )
      end)

    assert %Windog.Structs.PredictComment{} = head
  end

  test "to_raw_map/1" do
    sample =
      "test/samples/predict_comments_2023072822_3_1.json"
      |> File.read!()
      |> Jason.decode!()

    [head | _] =
      sample["comments"]
      |> Enum.map(fn c ->
        tipster = sample["tipsters"] |> Enum.find(fn t -> t["id"] == c["tipsterId"] end)

        Windog.Convertor.PredictComment.from_response(c, tipster,
          cup_id: "2023072822",
          day_index: 3,
          r: 1
        )
      end)

    assert %{} = Windog.Convertor.PredictComment.to_raw_map(head)
  end
end
