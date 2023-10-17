defmodule Windog.Convertor.Race.FromRawMap do
  alias Windog.Convertor

  alias Windog.Structs.{
    RaceContext,
    Race,
    Cup,
    ResultItem,
    PlayerDetail,
    Player,
    ResultHistory,
    ResultHistoryRace,
    PlayerRecord,
    PlayerRecordLegType,
    PlayerRecordPercent,
    PlayerRecordEx,
    PlayerRecordExCount,
    PlayerRecordExCountMin,
    PlayerRecordSB,
    Venue
  }

  def run(map) do
    str_map = Convertor.Common.Utils.stringify_keys(map)

    players =
      str_map["players"]
      |> Enum.map(fn p ->
        Player.validate(%{
          number: p["number"],
          absent: p["absent"],
          player_id: p["player_id"],
          player: PlayerDetail.validate(to_atom_map(p["player"])),
          record:
            PlayerRecord.validate(%{
              countable: p["record"]["countable"],
              style: p["record"]["style"],
              race_point: p["record"]["race_point"],
              comment: p["record"]["comment"],
              sb: PlayerRecordSB.validate(to_atom_map(p["record"]["sb"])),
              percent: PlayerRecordPercent.validate(to_atom_map(p["record"]["percent"])),
              leg_type: PlayerRecordLegType.validate(to_atom_map(p["record"]["leg_type"])),
              ex:
                PlayerRecordEx.validate(%{
                  is_line_1:
                    PlayerRecordExCount.validate(to_atom_map(p["record"]["ex"]["is_line_1"])),
                  is_line_2:
                    PlayerRecordExCount.validate(to_atom_map(p["record"]["ex"]["is_line_2"])),
                  is_line_tail:
                    PlayerRecordExCount.validate(to_atom_map(p["record"]["ex"]["is_line_tail"])),
                  is_single:
                    PlayerRecordExCount.validate(to_atom_map(p["record"]["ex"]["is_single"])),
                  chigiri:
                    PlayerRecordExCountMin.validate(to_atom_map(p["record"]["ex"]["chigiri"])),
                  chigirare:
                    PlayerRecordExCountMin.validate(to_atom_map(p["record"]["ex"]["chigirare"])),
                  tobitsuki:
                    PlayerRecordExCountMin.validate(to_atom_map(p["record"]["ex"]["tobitsuki"])),
                  tsuppari:
                    PlayerRecordExCountMin.validate(to_atom_map(p["record"]["ex"]["tsuppari"]))
                })
            }),
          current_cup:
            Enum.map(p["current_cup"], fn r ->
              ResultHistoryRace.validate(to_atom_map(r))
            end),
          previous_cup:
            Enum.map(p["previous_cup"], fn r ->
              ResultHistoryRace.validate(to_atom_map(r))
            end),
          latest_cups:
            Enum.map(p["latest_cups"], fn lc ->
              ResultHistory.validate(%{
                race_point: lc["race_point"],
                cup_id: lc["cup_id"],
                races:
                  Enum.map(lc["races"], fn r ->
                    ResultHistoryRace.validate(to_atom_map(r))
                  end)
              })
            end)
        })
      end)

    line = str_map["line"]

    results =
      str_map["results"]
      |> Enum.map(fn r ->
        ResultItem.validate(to_atom_map(r))
      end)

    odds = Convertor.Odds.from_raw_map(str_map["odds"])

    race = Race.validate(to_atom_map(str_map["race"]))
    cup = Cup.validate(to_atom_map(str_map["cup"]))
    has_absent_player = players |> Enum.any?(fn p -> p.absent end)
    has_accident = results |> Enum.any?(fn r -> r.accident != nil end)
    is_defect_line = line == nil
    is_finish = results != []
    venue = Venue.validate(to_atom_map(str_map["venue"]))

    RaceContext.validate(%{
      players: players,
      line: line,
      results: results,
      odds: odds,
      odds_updated_at: str_map["odds_updated_at"],
      race: race,
      cup: cup,
      venue: venue,
      is_defect_line: is_defect_line,
      has_accident: has_accident,
      has_absent_player: has_absent_player,
      is_finish: is_finish
    })
  end

  defp to_atom_map(map) do
    Convertor.Common.Utils.to_atom_map(map)
  end
end
