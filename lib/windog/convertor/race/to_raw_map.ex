defmodule Windog.Convertor.Race.ToRawMap do
  def run(%NaiveDateTime{} = encodable_struct), do: encodable_struct
  def run(%DateTime{} = encodable_struct), do: encodable_struct
  def run(%Time{} = encodable_struct), do: encodable_struct
  def run(%Date{} = encodable_struct), do: encodable_struct

  def run(struct_or_map) when is_map(struct_or_map) do
    struct_or_map
    |> Map.delete(:__struct__)
    |> Map.delete(:__meta__)
    |> Map.new(fn
      {k, v} when is_map(v) -> {k, run(v)}
      {k, v} when is_list(v) -> {k, Enum.map(v, &run/1)}
      kv -> kv
    end)
  end

  def run(map) do
    map
  end
end
