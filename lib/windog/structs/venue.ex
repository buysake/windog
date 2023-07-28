defmodule Windog.Structs.Venue do
  @keys [
    :slug,
    :name,
    :id,
    :region_id,
    :straight_distance,
    :distance,
    :has_food,
    :home_width,
    :back_width,
    :best_agari
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        slug: slug,
        name: name,
        id: id,
        region_id: region_id,
        distance: distance,
        straight_distance: straight_distance,
        home_width: home_width,
        back_width: back_width,
        has_food: has_food,
        best_agari: best_agari
      })
      when is_binary(slug) and is_binary(name) and is_binary(id) and is_binary(region_id) and
             is_boolean(has_food) and is_number(straight_distance) and is_number(distance) and
             is_number(back_width) and is_number(home_width) and is_number(best_agari) do
    %__MODULE__{
      slug: slug,
      name: name,
      id: id,
      region_id: region_id,
      has_food: has_food,
      distance: distance,
      straight_distance: straight_distance,
      home_width: home_width,
      back_width: back_width,
      best_agari: best_agari
    }
  end
end
