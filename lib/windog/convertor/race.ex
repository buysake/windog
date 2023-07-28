defmodule Windog.Convertor.Race do
  alias Windog.Structs
  alias Windog.Convertor.Race.{FromResponse, FromRawMap, ToRawMap}

  def from_response(body) do
    FromResponse.run(body)
  end

  def to_raw_map(%Structs.RaceContext{} = struct) do
    ToRawMap.run(struct)
  end

  def from_raw_map(map) do
    FromRawMap.run(map)
  end
end
