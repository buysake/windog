defmodule Windog.Structs.PlayerRecordExCount do
  @keys [
    :first,
    :second,
    :third,
    :total
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        first: first,
        second: second,
        third: third,
        total: total
  })
      when is_number(first) and is_number(second) and is_number(third) and is_number(total) do
    %__MODULE__{
      first: first,
      second: second,
      third: third,
      total: total
    }
  end
end
