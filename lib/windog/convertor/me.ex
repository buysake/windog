defmodule Windog.Convertor.Me do
  alias Windog.Structs
  alias Windog.Convertor.Me.FromResponse
  alias Windog.Convertor.Common.ToRawMap

  def from_response(me_r) do
    FromResponse.run(me_r)
  end

  def to_raw_map(%Structs.Me{} = struct) do
    ToRawMap.run(struct)
  end
end
