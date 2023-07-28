defmodule Windog.Utils do
  alias Windog.Structs

  def build_race_url(%Structs.RaceContext{} = struct) do
    "https://www.winticket.jp/keirin/#{struct.venue.slug}/racecard/#{struct.cup.id}/#{struct.race.day_index}/#{struct.race.r}"
  end
end
