defmodule Windog.Convertor.Odds.FromRawMap do
  alias Windog.Convertor
  alias Windog.Structs.{OddsItem, Odds}

  def run(map) do
    str_map = Convertor.Common.Utils.stringify_keys(map)

    Odds.validate(%{
      nishatan: str_map["nishatan"] |> Enum.map(fn v -> OddsItem.validate(to_atom_map(v)) end),
      nishafuku: str_map["nishafuku"] |> Enum.map(fn v -> OddsItem.validate(to_atom_map(v)) end),
      sanrenpuku:
        str_map["sanrenpuku"] |> Enum.map(fn v -> OddsItem.validate(to_atom_map(v)) end),
      sanrentan: str_map["sanrentan"] |> Enum.map(fn v -> OddsItem.validate(to_atom_map(v)) end),
      updated_at: str_map["updated_at"]
    })
  end

  defp to_atom_map(map) do
    Convertor.Common.Utils.to_atom_map(map)
  end
end
