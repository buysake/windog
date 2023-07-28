defmodule Windog.Structs.ResultHistoryRace do
  # 近走欄に乗るリザルト

  @keys [
    :day,
    :has_accident,
    :accident,
    :back,
    :standing,
    :order,
    :agari_time,
    :race_id,
    :display_type,
    :factor,
    :margin,
    :race_type_short
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        day: day,
        has_accident: has_accident,
        accident: accident,
        back: back,
        standing: standing,
        agari_time: agari_time,
        order: order,
        race_id: race_id,
        display_type: display_type,
        factor: factor,
        margin: margin,
        race_type_short: race_type_short
      })
      when is_integer(day) and is_boolean(has_accident) and
             (is_binary(accident) or is_nil(accident)) and
             is_boolean(standing) and is_boolean(back) and is_integer(order) and
             is_float(agari_time) and is_binary(race_id) and is_integer(display_type) and
             is_binary(factor) and is_binary(race_type_short) and is_binary(margin) do
    %__MODULE__{
      agari_time: agari_time,
      day: day,
      has_accident: has_accident,
      accident: accident,
      back: back,
      standing: standing,
      order: order,
      race_id: race_id,
      display_type: display_type,
      factor: factor,
      margin: margin,
      race_type_short: race_type_short
    }
  end
end
