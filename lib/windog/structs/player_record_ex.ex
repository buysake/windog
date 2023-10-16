defmodule Windog.Structs.PlayerRecordEx do
  alias Windog.Structs.{PlayerRecordExCount, PlayerRecordExCountMin}

  @keys [
    :is_line_1,
    :is_line_2,
    :is_line_tail,
    :is_single,
    # exLeftBehind
    :chigiri,
    # exSplitLine
    :chigirare,
    # exSnatch
    :tobitsuki,
    # exThrust
    :tsuppari
  ]

  @enforce_keys @keys

  defstruct @keys

  def validate(%{
        is_line_1: %PlayerRecordExCount{} = is_line_1,
        is_line_2: %PlayerRecordExCount{} = is_line_2,
        is_line_tail: %PlayerRecordExCount{} = is_line_tail,
        is_single: %PlayerRecordExCount{} = is_single,
        chigiri: %PlayerRecordExCountMin{} = chigiri,
        chigirare: %PlayerRecordExCountMin{} = chigirare,
        tobitsuki: %PlayerRecordExCountMin{} = tobitsuki,
        tsuppari: %PlayerRecordExCountMin{} = tsuppari
      }) do
    %__MODULE__{
      is_line_1: is_line_1,
      is_line_2: is_line_2,
      is_line_tail: is_line_tail,
      is_single: is_single,
      chigiri: chigiri,
      chigirare: chigirare,
      tobitsuki: tobitsuki,
      tsuppari: tsuppari
    }
  end
end
