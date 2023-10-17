defmodule Windog.Structs.Odds do
  alias Windog.Structs

  @keys [
    :nishatan,
    :nishafuku,
    :sanrenpuku,
    :sanrentan,
    :updated_at
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        nishafuku: [%Structs.OddsItem{} | _] = nishafuku,
        nishatan: [%Structs.OddsItem{} | _] = nishatan,
        sanrenpuku: [%Structs.OddsItem{} | _] = sanrenpuku,
        sanrentan: [%Structs.OddsItem{} | _] = sanrentan,
        updated_at: updated_at
      })
      when is_number(updated_at) do
    %__MODULE__{
      nishatan: nishatan,
      nishafuku: nishafuku,
      sanrenpuku: sanrenpuku,
      sanrentan: sanrentan,
      updated_at: updated_at
    }
  end
end
