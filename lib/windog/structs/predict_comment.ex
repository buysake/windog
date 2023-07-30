defmodule Windog.Structs.PredictComment do
  @keys [
    :comment,
    :comment_id,
    :tipster_id,
    :tipster_name,
    :created_at,
    :cup_id,
    :day_index,
    :r
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        comment: comment,
        comment_id: comment_id,
        tipster_id: tipster_id,
        tipster_name: tipster_name,
        created_at: created_at,
        cup_id: cup_id,
        day_index: day_index,
        r: r
      })
      when is_binary(comment) and is_binary(tipster_id) and is_binary(tipster_name) and
             is_binary(comment_id) and is_integer(created_at) and is_binary(cup_id) and
             is_integer(day_index) and is_integer(r) do
    %__MODULE__{
      comment: comment,
      comment_id: comment_id,
      tipster_id: tipster_id,
      tipster_name: tipster_name,
      created_at: created_at,
      cup_id: cup_id,
      day_index: day_index,
      r: r
    }
  end
end
