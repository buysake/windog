defmodule Windog.Structs.ResultItem do
  @keys [
    :number,
    :player_id,
    :has_accident,
    :accident,
    :factor,
    :agari_time,
    :standing,
    :back,
    :order,
    :margin,
    :margin_by_top
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        number: number,
        player_id: player_id,
        has_accident: has_accident,
        accident: accident,
        factor: factor,
        agari_time: agari_time,
        standing: standing,
        back: back,
        order: order,
        margin: margin,
        margin_by_top: margin_by_top
      })
      when is_binary(number) and is_binary(player_id) and is_boolean(has_accident) and
             (is_binary(accident) or is_nil(accident)) and
             (is_float(agari_time) or is_nil(agari_time)) and
             is_boolean(standing) and is_boolean(back) and
             (order in 1..9 or is_nil(order)) and
             (is_float(margin) or is_nil(margin)) and
             (is_float(margin_by_top) or is_nil(margin_by_top)) do
    %__MODULE__{
      number: number,
      player_id: player_id,
      has_accident: has_accident,
      accident: accident,
      factor: factor,
      agari_time: agari_time,
      standing: standing,
      back: back,
      order: order,
      margin: margin,
      margin_by_top: margin_by_top
    }
  end
end
