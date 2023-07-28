defmodule Windog.Structs.ResultItem do
  @keys [
    :number,
    :player_id,
    :has_accident,
    :accident,
    :factor,
    :agari_time,
    :standing,
    :back
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
        back: back
      })
      when is_binary(number) and is_binary(player_id) and is_boolean(has_accident) and
             (is_binary(accident) or is_nil(accident)) and is_float(agari_time) and
             is_boolean(standing) and is_boolean(back) do
    %__MODULE__{
      number: number,
      player_id: player_id,
      has_accident: has_accident,
      accident: accident,
      factor: factor,
      agari_time: agari_time,
      standing: standing,
      back: back
    }
  end
end
