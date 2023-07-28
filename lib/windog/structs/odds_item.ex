defmodule Windog.Structs.OddsItem do
  @keys [
    :key,
    :odds
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{key: [k | _] = ks, odds: odds})
      when is_binary(k) and is_number(odds) do
    %__MODULE__{
      key: ks,
      odds: odds
    }
  end
end
