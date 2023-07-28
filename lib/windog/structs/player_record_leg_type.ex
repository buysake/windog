defmodule Windog.Structs.PlayerRecordLegType do
  @keys [
    :nige,
    :sashi,
    :makuri,
    :marker
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{nige: nige, sashi: sashi, makuri: makuri, marker: marker})
      when is_integer(nige) and is_integer(sashi) and is_integer(makuri) and is_integer(marker) do
    %__MODULE__{
      nige: nige,
      sashi: sashi,
      makuri: makuri,
      marker: marker
    }
  end
end
