defmodule Windog.Utils.BracketNumber do
  def get_bracket_number(player_number, total_players) do
    _get_bracket_number(player_number, total_players)
  end

  defp _get_bracket_number(1, _), do: 1
  defp _get_bracket_number(2, _), do: 2
  defp _get_bracket_number(3, _), do: 3
  defp _get_bracket_number(4, _), do: 4
  defp _get_bracket_number(5, 5), do: 5
  defp _get_bracket_number(5, 6), do: 5
  defp _get_bracket_number(5, 7), do: 5
  defp _get_bracket_number(5, 8), do: 5
  defp _get_bracket_number(5, 9), do: 4
  defp _get_bracket_number(6, 6), do: 6
  defp _get_bracket_number(6, 7), do: 6
  defp _get_bracket_number(6, 8), do: 5
  defp _get_bracket_number(6, 9), do: 5
  defp _get_bracket_number(7, 7), do: 6
  defp _get_bracket_number(7, 8), do: 6
  defp _get_bracket_number(7, 9), do: 5
  defp _get_bracket_number(8, _), do: 6
  defp _get_bracket_number(9, _), do: 6
end
