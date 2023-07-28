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
end
