defmodule Windog.Structs.Me do
  alias Windog.Structs

  @keys [
    :wallet,
    :stage
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        wallet: %Structs.Me.Wallet{} = wallet,
        stage: %Structs.Me.Stage{} = stage
      }) do
    %__MODULE__{
      wallet: wallet,
      stage: stage
    }
  end
end
