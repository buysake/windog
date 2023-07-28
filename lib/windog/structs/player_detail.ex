defmodule Windog.Structs.PlayerDetail do
  @keys [
    :name,
    :term,
    :class,
    :group,
    :region_id,
    :age
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        name: name,
        term: term,
        class: class,
        group: group,
        region_id: region_id,
        age: age
      })
      when is_binary(name) and is_integer(term) and is_integer(class) and is_integer(group) and
             is_binary(region_id) and is_integer(age) do
    %__MODULE__{
      name: name,
      term: term,
      class: class,
      group: group,
      region_id: region_id,
      age: age
    }
  end
end
