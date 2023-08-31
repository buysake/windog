defmodule Windog.Api.User do
  alias Windog.Api.Base

  def fetch_me() do
    case Base.get("/v1/users/me?pfm=web") do
      {:ok, %{body: body, status_code: 200}} ->
        {
          :ok,
          body
          |> Windog.Convertor.Me.from_response()
        }

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end

  def fetch_scheduled_points(receipt_type \\ 15) do
    case Base.get("/v1/users/me/scheduled-points?receipt_type=#{receipt_type}&pfm=web") do
      {:ok, %{body: %{"scheduledPoints" => [%{"totalAmount" => amount} | _]}, status_code: 200}} ->
        {:ok, amount}

      {:ok, %{body: _, status_code: 200}} ->
        {:error, :unknown_response}

      {:ok, %{body: body, status_code: status}} ->
        {:error, %{body: body, status: status}}

      {:error, e} ->
        {:error, e}
    end
  end
end
