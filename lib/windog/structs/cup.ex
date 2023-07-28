defmodule Windog.Structs.Cup do
  @keys [
    :id,
    :venue_id,
    :name,
    :grade,
    :start_date
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        grade: grade,
        venue_id: venue_id,
        name: name,
        id: id,
        start_date: %DateTime{} = start_date
      })
      when is_integer(grade) and is_binary(venue_id) and is_binary(name) and is_binary(id) do
    %__MODULE__{
      grade: grade,
      venue_id: venue_id,
      name: name,
      id: id,
      start_date: start_date
    }
  end
end
