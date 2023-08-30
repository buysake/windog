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
end
