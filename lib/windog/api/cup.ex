defmodule Windog.Api.Cup do
  alias Windog.Api.Base

  def fetch_cups_by_day(%Date{} = date) do
    date
    |> Timex.format("{YYYY}{0M}{0D}")
    |> fetch_cups_by_day()
  end

  def fetch_cups_by_day({:ok, slug}) when is_binary(slug) do
    fetch_cups_by_day(slug)
  end

  def fetch_cups_by_day({:error, e}) do
    {:error, e}
  end

  def fetch_cups_by_day(date_slug) when is_binary(date_slug) do
    path = "/v1/keirin/cups/-/schedules?date=#{date_slug}&pfm=web"

    case Base.get(path) do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          body["cups"]
          |> Enum.map(fn c -> Windog.Convertor.Cup.from_response(c) end)
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end

  def fetch_cup_races(cup_id, only_done \\ false) do
    path = "/v1/keirin/cups/#{cup_id}?fields=cup,races,schedules&pfm=web"

    case Base.get(path) do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          body["races"]
          |> filter_only_done(only_done)
          |> Enum.map(fn r ->
            schedule = Enum.find(body["schedules"], fn s -> r["scheduleId"] == s["id"] end)
            Windog.Convertor.CupRace.from_response(r, schedule)
          end)
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end

  defp filter_only_done(races_r, true = _enable) do
    races_r |> Enum.filter(fn r -> r["status"] == 3 and r["cancel"] != true end)
  end

  defp filter_only_done(races_r, false = _enable) do
    races_r
  end
end
