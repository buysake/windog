defmodule Windog.Convertor.Odds do
  alias Windog.Structs
  alias Windog.Convertor.Odds.{FromResponse, FromRawMap}
  alias Windog.Convertor.Common.ToRawMap

  def from_raw_map(map) do
    FromRawMap.run(map)
  end

  def from_response(odds_r) do
    FromResponse.run(odds_r)
  end

  def to_raw_map(%Structs.Odds{} = struct) do
    ToRawMap.run(struct)
  end
end
