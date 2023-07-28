defmodule Windog.Structs.PlayerRecordEx do
  alias Windog.Structs.PlayerRecordExCount

  @keys [
    :is_line_1,
    :is_line_2,
    :is_line_tail,
    :is_single
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        is_line_1: %PlayerRecordExCount{} = is_line_1,
        is_line_2: %PlayerRecordExCount{} = is_line_2,
        is_line_tail: %PlayerRecordExCount{} = is_line_tail,
        is_single: %PlayerRecordExCount{} = is_single
      }) do
    %__MODULE__{
      is_line_1: is_line_1,
      is_line_2: is_line_2,
      is_line_tail: is_line_tail,
      is_single: is_single
    }
  end
end
