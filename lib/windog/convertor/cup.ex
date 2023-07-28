defmodule Windog.Convertor.Cup do
  alias Windog.Structs
  alias Windog.Convertor.Cup.FromResponse
  alias Windog.Convertor.Common.ToRawMap

  def from_response(body) do
    FromResponse.run(body)
  end

  def to_raw_map(%Structs.Cup{} = struct) do
    ToRawMap.run(struct)
  end
end
