defmodule Windog.Structs.PredictComment do
  @keys [
    :comment,
    :comment_id,
    :tipster_id,
    :tipster_name,
    :created_at
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        comment: comment,
        comment_id: comment_id,
        tipster_id: tipster_id,
        tipster_name: tipster_name,
        created_at: created_at
      })
      when is_binary(comment) and is_binary(tipster_id) and is_binary(tipster_name) and
             is_binary(comment_id) and is_integer(created_at) do
    %__MODULE__{
      comment: comment,
      comment_id: comment_id,
      tipster_id: tipster_id,
      tipster_name: tipster_name,
      created_at: created_at
    }
  end
end
