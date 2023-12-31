defmodule Windog.Structs.RaceContext do
  alias Windog.Structs

  @keys [
    :players,
    :line,
    :results,
    :odds,
    :race,
    :cup,
    :venue,
    :is_defect_line,
    :has_absent_player,
    :has_accident,
    :is_finish
  ]

  @enforce_keys @keys

  defstruct @keys

  # finish: true
  def validate(%{
        players: [%Structs.Player{} | _] = players,
        results: [%Structs.ResultItem{} | _] = results,
        odds: %Structs.Odds{} = odds,
        race: %Structs.Race{} = race,
        cup: %Structs.Cup{} = cup,
        line: line,
        venue: %Structs.Venue{} = venue,
        is_defect_line: is_defect_line,
        has_absent_player: has_absent_player,
        has_accident: has_accident,
        is_finish: true = is_finish
      })
      when is_boolean(is_defect_line) and is_boolean(is_finish) and
             (is_list(line) or is_nil(line)) and is_boolean(has_accident) and
             is_boolean(has_absent_player) do
    %__MODULE__{
      players: players,
      line: line,
      results: results,
      odds: odds,
      race: race,
      cup: cup,
      venue: venue,
      is_defect_line: is_defect_line,
      has_absent_player: has_absent_player,
      has_accident: has_accident,
      is_finish: is_finish
    }
  end

  # finish: false
  def validate(%{
        players: [%Structs.Player{} | _] = players,
        results: [] = results,
        odds: %Structs.Odds{} = odds,
        race: %Structs.Race{} = race,
        cup: %Structs.Cup{} = cup,
        line: line,
        venue: %Structs.Venue{} = venue,
        is_defect_line: is_defect_line,
        has_absent_player: has_absent_player,
        has_accident: has_accident,
        is_finish: false = is_finish
      })
      when is_boolean(is_defect_line) and is_boolean(is_finish) and
             (is_list(line) or is_nil(line)) and is_boolean(has_absent_player) and
             is_boolean(has_accident) do
    %__MODULE__{
      players: players,
      line: line,
      results: results,
      odds: odds,
      race: race,
      cup: cup,
      venue: venue,
      is_defect_line: is_defect_line,
      has_absent_player: has_absent_player,
      has_accident: has_accident,
      is_finish: is_finish
    }
  end
end
