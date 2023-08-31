defmodule Windog.Convertor.Me.FromResponse do
  alias Windog.Structs.Me

  def run(me_r) do
    Me.validate(%{
      wallet:
        Me.Wallet.validate(%{
          main: me_r["wallet"]["main"],
          pending: me_r["wallet"]["pending"]
        }),
      stage:
        Me.Stage.validate(%{
          current: me_r["stage"]["current"],
          next: me_r["stage"]["next"],
          target: me_r["stage"]["target"],
          usage: me_r["stage"]["usage"],
          offset: me_r["stage"]["offset"],
          estimated: me_r["stage"]["estimated"]
        })
    })
  end
end
