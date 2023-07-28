defmodule Windog.Structs.Player do
  alias Windog.Structs

  @keys [
    :number,
    :absent,
    :player_id,
    :player,
    :record,
    :current_cup,
    :previous_cup,
    :latest_cups
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        number: number,
        absent: absent,
        player_id: player_id,
        player: %Structs.PlayerDetail{} = player,
        record: %Structs.PlayerRecord{} = record,
        current_cup: current_cup,
        previous_cup: previous_cup,
        latest_cups: latest_cups
      })
      when is_binary(number) and is_binary(player_id) and is_boolean(absent)
      when is_list(current_cup) and is_list(previous_cup) and is_list(latest_cups) do
    %__MODULE__{
      number: number,
      absent: absent,
      player_id: player_id,
      player: player,
      record: record,
      current_cup: current_cup,
      previous_cup: previous_cup,
      latest_cups: latest_cups
    }
  end
end
