defmodule Windog.Structs.PlayerRecordSB do
  @keys [
    :standing,
    :back
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        standing: standing,
        back: back
      })
      when is_integer(standing) and is_integer(back) do
    %__MODULE__{
      standing: standing,
      back: back
    }
  end
end
