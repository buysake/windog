defmodule Windog.Structs.Race do
  @keys [
    :id,
    :r,
    :day_index,
    :day,
    :start_at,
    :close_at,
    :type,
    :class,
    :distance,
    :lap,
    :date,
    :cup_id
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        id: id,
        date: %DateTime{} = date,
        r: r,
        day_index: day_index,
        day: day,
        start_at: start_at,
        close_at: close_at,
        type: type,
        class: class,
        distance: distance,
        lap: lap,
        cup_id: cup_id
      })
      when is_binary(id) and is_integer(r) and is_integer(day) and is_binary(type) and
             is_binary(class) and is_integer(distance) and is_integer(lap) and
             is_integer(day_index) and is_integer(start_at) and is_integer(close_at) and
             is_binary(cup_id) do
    %__MODULE__{
      id: id,
      date: date,
      r: r,
      day_index: day_index,
      day: day,
      start_at: start_at,
      close_at: close_at,
      type: type,
      class: class,
      distance: distance,
      lap: lap,
      cup_id: cup_id
    }
  end
end
