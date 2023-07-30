defmodule Windog.Convertor.PredictComment.FromResponse do
  alias Windog.Structs.PredictComment

  def run(comment_r, tipster_r) do
    PredictComment.validate(%{
      comment: comment_r["comment"],
      comment_id: comment_r["commentId"],
      created_at: comment_r["createdAt"],
      tipster_name: tipster_r["name"],
      tipster_id: tipster_r["id"]
    })
  end
end
