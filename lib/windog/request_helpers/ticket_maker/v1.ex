defmodule Windog.RequestHelpers.TicketMaker.V1 do
  def make_nishatan(key, amount) do
    make(4, key, amount)
  end

  def make_sanrentan(key, amount) do
    make(2, key, amount)
  end

  defp make(_type, _key, amount) when amount < 100 do
    :amount_error
  end

  defp make(type, key, _amount) when length(key) != 2 and type in [4] do
    :key_error
  end

  defp make(type, key, _amount) when length(key) != 3 and type in [2] do
    :key_error
  end

  defp make(type, key, amount) do
    cond do
      Enum.uniq(key) != key ->
        :key_error

      Enum.any?(key, &(&1 not in 1..9)) ->
        :key_error

      true ->
        key
        |> make_key_params()
        |> Map.merge(%{
          "type" => type,
          "style" => 0,
          "unitQuantity" => floor(amount / 100),
          "checksum" => 1
        })
    end
  end

  defp make_key_params([f, s]) do
    %{
      "first" => [f],
      "second" => [s],
      "third" => nil
    }
  end

  defp make_key_params([f, s, t]) do
    %{
      "first" => [f],
      "second" => [s],
      "third" => [t]
    }
  end
end
