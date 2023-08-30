defmodule Windog.Structs.Me.Wallet do
  @keys [
    :main,
    :pending
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        main: main,
        pending: pending
      })
      when is_integer(main) and is_integer(pending) do
    %__MODULE__{
      main: main,
      pending: pending
    }
  end
end
