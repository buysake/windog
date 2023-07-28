defmodule Windog.Convertor.Cup.FromResponse do
  alias Windog.Structs.Cup
  alias Windog.Convertor.Common.Utils

  # body: response of /v1/keirin/cups/:cup_id/schedules/:day/races/:r?pfm=web
  def run(body) do
    Cup.validate(%{
      grade: body["grade"],
      venue_id: body["venueId"],
      name: body["name"],
      id: body["id"],
      start_date: Utils.parse_response_date(body["startDate"])
    })
  end
end
