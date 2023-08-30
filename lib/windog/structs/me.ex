defmodule Windog.Structs.Me do
  alias Windog.Structs

  @keys [
    :wallet
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        wallet: %Structs.Me.Wallet{} = wallet
      }) do
    %__MODULE__{
      wallet: wallet
    }
  end
end
