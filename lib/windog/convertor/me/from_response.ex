defmodule Windog.Convertor.Me.FromResponse do
  alias Windog.Structs.Me

  def run(me_r) do
    Me.validate(%{
      wallet:
        Me.Wallet.validate(%{
          main: me_r["wallet"]["main"],
          pending: me_r["wallet"]["pending"]
        })
    })
  end
end
