defmodule Windog.Utils.Odds do
  alias Windog.Structs

  #
  # e.g. filter_odds(race.odds, :sanrentan, ["1"], ["1", "2", "3"], ["1", "2", "3"])
  #

  def filter_odds(%Structs.Odds{} = odds, :sanrentan, one_line, two_line, three_line) do
    _filter_odds(odds.sanrentan, false, one_line, two_line, three_line)
  end

  def filter_odds(%Structs.Odds{} = odds, :sanrenpuku, one_line, two_line, three_line) do
    _filter_odds(odds.sanrenpuku, true, one_line, two_line, three_line)
  end

  def filter_odds(%Structs.Odds{} = odds, :nishatan, one_line, two_line) do
    _filter_odds(odds.nishatan, false, one_line, two_line, [])
  end

  def filter_odds(%Structs.Odds{} = odds, :nishafuku, one_line, two_line) do
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

  def allocation([%Structs.OddsItem{} | _] = odds_items, budget) do
    odds_items
    |> Enum.map(fn odds -> {odds, 0} end)
    |> allocation(budget)
  end

  def allocation([{%Structs.OddsItem{}, _} | _] = odds_with_amounts, budget) when budget < 100 do
    odds_with_amounts
  end

  def allocation([{%Structs.OddsItem{}, _} | _] = odds_with_amounts, budget) do
    {_, min_index} =
      odds_with_amounts
      |> Enum.with_index()
      |> Enum.sort(fn {{%{odds: a_odds}, a_amount}, _}, {{%{odds: b_odds}, b_amount}, _} ->
        a_odds * a_amount < b_odds * b_amount
      end)
      |> Enum.at(0)

    odds_with_amounts
    |> Enum.with_index()
    |> Enum.map(fn {{odds, amount}, index} ->
      if index == min_index,
        do: {odds, amount + 100},
        else: {odds, amount}
    end)
    |> allocation(budget - 100)
  end
end
