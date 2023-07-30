defmodule Windog.Convertor.PredictComment do
  alias Windog.Structs
  alias Windog.Convertor.PredictComment.FromResponse
  alias Windog.Convertor.Common.ToRawMap

  def from_response(comment, tipster, cup_id: cup_id, day_index: day_index, r: r) do
    FromResponse.run(comment, tipster, cup_id: cup_id, day_index: day_index, r: r)
  end

  def to_raw_map(%Structs.PredictComment{} = struct) do
    ToRawMap.run(struct)
  end
end
