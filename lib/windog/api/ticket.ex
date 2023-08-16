defmodule Windog.Api.Ticket do
  alias Windog.Structs.RaceContext
  alias Windog.Api.Base
  alias Windog.Utils.HTTPoisonHelper

  def buy(%RaceContext{} = context, [_ | _] = tickets) do
    short_password = Application.get_env(:windog, :short_password)
    buy(context, tickets, short_password)
  end

  def buy(_, _) do
    {:error, :tickets_empty}
  end

  defp buy(_, _, nil) do
    {:error, :not_set_password}
  end

  defp buy(%RaceContext{} = context, [_ | _] = tickets, short_password) do
    path =
      "/v1/keirin/cups/#{context.cup.id}/schedules/#{context.race.day_index}/races/#{context.race.r}/betting-tickets?pfm=web"

    body = %{
      "requestId" => UUID.uuid4(),
      "raceId" => context.race.id,
      "shortPassword" => short_password,
      "tickets" => tickets
    }

    case Base.post(path, Jason.encode!(body)) do
      {:ok, %{status_code: 200, body: _, headers: headers}} ->
        responsed_at = HTTPoisonHelper.get_date_from_header(headers)
        {:ok, responsed_at}

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end
end
