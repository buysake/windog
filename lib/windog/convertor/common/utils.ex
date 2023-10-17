defmodule Windog.Convertor.Common.Utils do
  # * winticketはYYYYMMDDで日付を扱う
  # * それをmongoで扱うよう最適化
  def parse_response_date(date_str) do
    date_str
    |> Timex.parse!("{YYYY}{0M}{0D}")
    |> Timex.Timezone.convert("Asia/Tokyo")
  end

  def stringify_keys(nil), do: nil

  def stringify_keys(%DateTime{} = dt) do
    dt
  end

  def stringify_keys(%{} = map) do
    map
    |> Enum.map(fn {k, v} ->
      next_k =
        if is_atom(k),
          do: Atom.to_string(k),
          else: k

      {next_k, stringify_keys(v)}
    end)
    |> Enum.into(%{})
  end

  def stringify_keys([head | rest]) do
    [stringify_keys(head) | stringify_keys(rest)]
  end

  def stringify_keys(not_a_map) do
    not_a_map
  end

  def to_atom_map(map) do
    map
    |> Enum.into(Map.new(), fn {k, v} -> {String.to_atom(k), v} end)
  end
end
