defmodule Windog.Structs.PlayerRecordExCountMin do
  @keys [
    :succeeded,
    :total
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        succeeded: succeeded,
        total: total
      })
      when is_number(succeeded) and is_number(total) do
    %__MODULE__{
      succeeded: succeeded,
      total: total
    }
  end
end
