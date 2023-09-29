defmodule Windog.RequestHelpers.TicketMaker.V2 do
  alias Windog.Utils.BracketNumber

  # -----------------------------------
  # NOTE: make_nishatan/2, make_sanrentan/2
  # * not supported `multi`
  # * All amounts are set as `1`
  # -----------------------------------

  def make_nishatan([[s | _], [_ | _]] = formation, total_players) when is_integer(s) do
    %{
      "type" => 4,
      "style" => 0,
      "favoriteType" => 0,
      "aggregateSelection" => %{
        "multi" => false,
        "entrySelections" => make_selections(formation, total_players)
      },
      "points" => make_points(formation)
    }
  end

  def make_sanrentan([[s | _], [_ | _], [_ | _]] = formation, total_players) when is_integer(s) do
    %{
      "type" => 2,
      "style" => 0,
      "favoriteType" => 0,
      "aggregateSelection" => %{
        "multi" => false,
        "entrySelections" => make_selections(formation, total_players)
      },
      "points" => make_points(formation)
    }
  end

  defp make_selections([[_ | _], [_ | _], [_ | _]] = formation, total_players) do
    _make_selections(formation, total_players)
  end

  defp make_selections([[_ | _], [_ | _]] = formation, total_players) do
    _make_selections(Enum.concat(formation, [[]]), total_players)
  end

  defp _make_selections([f1, f2, f3] = _formation, total_players) do
    1..total_players
    |> Enum.map(fn n ->
      %{
        "entryNumber" => n,
        "bracketNumber" => BracketNumber.get_bracket_number(n, total_players),
        "selection" => %{
          "favoriteFirst" => false,
          "favoriteSecond" => false,
          "placeFirst" => n in f1,
          "placeSecond" => n in f2,
          "placeThird" => n in f3
        }
      }
    end)
  end

  defp make_points([[_ | _], [_ | _]] = formation) do
    [f1, f2] = formation

    f1
    |> Enum.map(fn a ->
      f2
      |> Enum.map(fn b -> {a, b} end)
    end)
    |> List.flatten()
    |> Enum.map(fn {a, b} ->
      %{
        "key" => [a, b],
        "unitQuantity" => 1
      }
    end)
  end

  defp make_points([[_ | _], [_ | _], [_ | _]] = formation) do
    [f1, f2, f3] = formation

    f1
    |> Enum.map(fn a ->
      f2
      |> Enum.map(fn b ->
        f3
        |> Enum.map(fn c -> {a, b, c} end)
      end)
    end)
    |> List.flatten()
    |> Enum.map(fn {a, b, c} ->
      %{
        "key" => [a, b, c],
        "unitQuantity" => 1
      }
    end)
  end

  # -----------------------------------
  # NOTE: set_unit/3
  # * Rewrites `unitQuantity` of the item matching the specified key
  # -----------------------------------

  def set_unit(tickets, key, unit) when is_list(key) and is_integer(unit) do
    next =
      tickets["points"]
      |> Enum.map(fn %{"key" => k, "unitQuantity" => q} ->
        if k != key,
          do: %{"key" => k, "unitQuantity" => q},
          else: %{
            "key" => k,
            "unitQuantity" => unit
          }
      end)

    Map.put(tickets, "points", next)
  end
end
