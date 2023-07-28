defmodule Windog.Convertor.Common.Utils do
  # * winticketはYYYYMMDDで日付を扱う
  # * それをmongoで扱うよう最適化
  def parse_response_date(date_str) do
    date_str
    |> Timex.parse!("{YYYY}{0M}{0D}")
    |> Timex.Timezone.convert("Asia/Tokyo")
  end
end
