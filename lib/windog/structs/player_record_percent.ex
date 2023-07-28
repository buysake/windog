defmodule Windog.Structs.PlayerRecordPercent do
  @keys [
    :in_1,
    :in_2,
    :in_3
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        in_1: in_1,
        in_2: in_2,
        in_3: in_3
      })
      when is_number(in_1) and is_number(in_2) and is_number(in_3) do
    %__MODULE__{
      in_1: in_1,
      in_2: in_2,
      in_3: in_3
    }
  end
end
