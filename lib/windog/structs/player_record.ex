defmodule Windog.Structs.PlayerRecord do
  alias Windog.Structs

  @keys [
    :comment,
    :race_point,
    :sb,
    :percent,
    :leg_type,
    :style,
    :ex,
    # 1着+2着+3着+着外
    :countable
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        comment: comment,
        style: style,
        race_point: race_point,
        countable: countable,
        sb: %Structs.PlayerRecordSB{} = sb,
        percent: %Structs.PlayerRecordPercent{} = percent,
        leg_type: %Structs.PlayerRecordLegType{} = leg_type,
        ex: %Structs.PlayerRecordEx{} = ex
      })
      when is_number(race_point) and is_binary(style) do
    %__MODULE__{
      countable: countable,
      comment: comment,
      style: style,
      race_point: race_point,
      sb: sb,
      percent: percent,
      leg_type: leg_type,
      ex: ex
    }
  end
end
