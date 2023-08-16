defmodule Windog.Utils.HTTPoisonHelper do
  def get_date_from_header(headers) do
    hit =
      headers
      |> Enum.find(fn {k, _} -> k == "Date" end)

    case hit do
      {"Date", v} ->
        v
        |> Timex.parse!("{RFC1123}")
        |> Timex.to_unix()

      _ ->
        nil
    end
  end
end
