defmodule Windog.Structs.Me.Stage do
  @keys [
    :current,
    :next,
    :target,
    :usage,
    :offset,
    :estimated
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        current: current,
        next: next,
        target: target,
        usage: usage,
        offset: offset,
        estimated: estimated
      })
      when current in 1..4 and is_integer(next) and is_integer(target) and is_number(offset) and
             is_integer(usage) and
             estimated in 1..4 do
    %__MODULE__{
      current: current,
      next: next,
      target: target,
      usage: usage,
      offset: offset,
      estimated: estimated
    }
  end
end
