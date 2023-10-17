defmodule Windog.Api.Race do
  alias Windog.Api.Base

  def get_race(cup_id, day_index, r) do
    path = "/v1/keirin/cups/#{cup_id}/schedules/#{day_index}/races/#{r}?pfm=web"

    case Base.get(path) do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          Windog.Convertor.Race.from_response(body)
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end

  def get_race_predict(cup_id, day_index, r) when is_integer(day_index) and is_integer(r) do
    path =
      "/v1/keirin/cups/#{cup_id}/schedules/#{day_index}/races/#{r}/prediction-comments?limit=20&token=&fields=comments,reactions,tipsters,token,hasNext,status&pfm=web"

    case Base.get(path) do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          body["comments"]
          |> Enum.map(fn c ->
            tipster = body["tipsters"] |> Enum.find(fn t -> t["id"] == c["tipsterId"] end)

            Windog.Convertor.PredictComment.from_response(c, tipster,
              cup_id: cup_id,
              day_index: day_index,
              r: r
            )
          end)
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end

  def get_race_odds(cup_id, day_index, r) do
    path = "/v1/keirin/cups/#{cup_id}/schedules/#{day_index}/races/#{r}/odds?pfm=web"

    case Base.get(path) do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          Windog.Convertor.Odds.from_response(body)
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end
end
