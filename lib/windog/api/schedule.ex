defmodule Windog.Api.Schedule do
  alias Windog.Api.Base

  def fetch_schedule_races(%Date{} = date) do
    date
    |> Timex.format("{YYYY}{0M}{0D}")
    |> fetch_schedule_races()
  end

  def fetch_schedule_races({:ok, slug}) when is_binary(slug) do
    fetch_schedule_races(slug)
  end

  def fetch_schedule_races({:error, e}) do
    {:error, e}
  end

  def fetch_schedule_races(date_slug) when is_binary(date_slug) do
    path = "/v1/keirin/cups/-/schedules?date=#{date_slug}&pfm=web"

    case Base.get(path) do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          body["races"]
          |> Enum.map(fn r ->
            schedule = Enum.find(body["schedules"], fn s -> r["scheduleId"] == s["id"] end)
            cup = Enum.find(body["cups"], fn c -> schedule["cupId"] == c["id"] end)
            Windog.Convertor.CupRace.from_response(r, schedule, cup)
          end)
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end
end
