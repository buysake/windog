defmodule Windog.Convertor.Odds.FromResponse do
  alias Windog.Structs.{Odds, OddsItem}

  def run(%{"quinella" => _} = odds_r) do
    Odds.validate(%{
      nishafuku: parse_odds(odds_r["quinella"]),
      nishatan: parse_odds(odds_r["exacta"]),
      sanrenpuku: parse_odds(odds_r["trio"]),
      sanrentan: parse_odds(odds_r["trifecta"]),
      updated_at: odds_r["oddsUpdatedAt"]
    })
  end

  defp parse_odds([%{"key" => _, "odds" => _} | _] = odds) do
    odds
    |> Enum.map(fn odd ->
      OddsItem.validate(%{
        key: Enum.map(odd["key"], fn k -> "#{k}" end),
        odds: odd["odds"]
      })
    end)
  end
end
