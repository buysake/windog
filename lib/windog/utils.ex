defmodule Windog.Utils do
  alias Windog.Structs

  def build_race_url(%Structs.RaceContext{} = struct) do
    "https://www.winticket.jp/keirin/#{struct.venue.slug}/racecard/#{struct.cup.id}/#{struct.race.day_index}/#{struct.race.r}"
  end

  #
  # e.g. filter_odds(race.odds, :sanrentan, ["1"], ["1", "2", "3"], ["1", "2", "3"])
  #

  def filter_odds(%Structs.OddsCategory{} = odds, :sanrentan, one_line, two_line, three_line) do
    _filter_odds(odds.sanrentan, false, one_line, two_line, three_line)
  end

  def filter_odds(%Structs.OddsCategory{} = odds, :sanrenpuku, one_line, two_line, three_line) do
    _filter_odds(odds.sanrenpuku, true, one_line, two_line, three_line)
  end

  def filter_odds(%Structs.OddsCategory{} = odds, :nishatan, one_line, two_line, _) do
    _filter_odds(odds.nishatan, false, one_line, two_line, [])
  end

  def filter_odds(%Structs.OddsCategory{} = odds, :nishafuku, one_line, two_line, _) do
    _filter_odds(odds.nishafuku, true, one_line, two_line, [])
  end

  def filter_odds(%Structs.OddsCategory{} = odds, :nishatan, one_line, two_line) do
    _filter_odds(odds.nishatan, false, one_line, two_line, [])
  end

  def filter_odds(%Structs.OddsCategory{} = odds, :nishafuku, one_line, two_line) do
    _filter_odds(odds.nishafuku, true, one_line, two_line, [])
  end

  defp _filter_odds(
         [%Structs.OddsItem{} | _] = odds_items,
         false = _in_not_particular_order,
         one_line,
         two_line,
         three_line
       )
       when is_list(one_line) and is_list(two_line) and is_list(three_line) do
    odds_items
    |> Enum.filter(fn odds ->
      case odds.key do
        [o, t] ->
          o in one_line and t in two_line

        [o, t, th] ->
          o in one_line and t in two_line and th in three_line
      end
    end)
  end

  defp _filter_odds(
         [%Structs.OddsItem{} | _] = odds_items,
         true = _in_not_particular_order,
         one_line,
         two_line,
         three_line
       )
       when is_list(one_line) and is_list(two_line) and is_list(three_line) do
    odds_items
    |> Enum.filter(fn odds ->
      case odds.key do
        [o, t] ->
          (o in one_line and t in two_line) or
            (t in one_line and o in two_line)

        [o, t, th] ->
          (o in one_line and t in two_line and th in three_line) or
            (o in one_line and th in two_line and t in three_line) or
            (t in one_line and o in two_line and th in three_line) or
            (t in one_line and th in two_line and o in three_line) or
            (th in one_line and o in two_line and t in three_line) or
            (th in one_line and t in two_line and o in three_line)
      end
    end)
  end
end
