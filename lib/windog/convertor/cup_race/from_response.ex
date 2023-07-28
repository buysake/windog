defmodule Windog.Convertor.CupRace.FromResponse do
  alias Windog.Structs.Race
  alias Windog.Convertor.Common.Utils

  def run(%{} = race, %{} = schedule) do
    Race.validate(%{
      id: race["id"],
      r: race["number"],
      day_index: schedule["index"],
      day: schedule["day"],
      start_at: race["startAt"],
      close_at: race["closeAt"],
      type: race["raceType"],
      class: race["class"],
      distance: race["distance"],
      lap: race["lap"],
      date: Utils.parse_response_date(schedule["date"])
    })
  end
end
