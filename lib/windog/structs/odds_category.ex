defmodule Windog.Structs.OddsCategory do
  alias Windog.Structs

  @keys [
    :nishatan,
    :nishafuku,
    :sanrenpuku,
    :sanrentan
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
    nishafuku: [%Structs.OddsItem{} | _] = nishafuku,
    nishatan: [%Structs.OddsItem{} | _] = nishatan,
    sanrenpuku: [%Structs.OddsItem{} | _] = sanrenpuku,
    sanrentan: [%Structs.OddsItem{} | _] = sanrentan,
      }) do
    %__MODULE__{
      nishatan: nishatan,
      nishafuku: nishafuku,
      sanrenpuku: sanrenpuku,
      sanrentan: sanrentan
    }
  end
end
