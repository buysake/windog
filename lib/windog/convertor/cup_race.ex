defmodule Windog.Convertor.CupRace do
  alias Windog.Structs
  alias Windog.Convertor.CupRace.FromResponse
  alias Windog.Convertor.Common.ToRawMap

  def from_response(race, schedule) do
    FromResponse.run(race, schedule)
  end

  def to_raw_map(%Structs.Race{} = struct) do
    ToRawMap.run(struct)
  end
end
