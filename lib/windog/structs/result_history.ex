defmodule Windog.Structs.ResultHistory do
  # 近走欄に乗るリザルト

  @keys [
    :cup_id,
    :race_point,
    :races
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        cup_id: cup_id,
        race_point: race_point,
        races: [%Windog.Structs.ResultHistoryRace{} | _] = races
      })
      when is_binary(cup_id) and (is_float(race_point) or is_nil(race_point)) and is_list(races) do
    %__MODULE__{
      cup_id: cup_id,
      race_point: race_point,
      races: races
    }
  end
end
