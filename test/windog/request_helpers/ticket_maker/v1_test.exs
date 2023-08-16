defmodule Windog.RequestHelpers.TicketMaker.V1Test do
  use ExUnit.Case
  doctest Windog
  alias Windog.RequestHelpers.TicketMaker

  test "make_nishatan/2" do
    assert %{"type" => 4, "first" => [1], "second" => [2], "unitQuantity" => 2} =
             TicketMaker.V1.make_nishatan([1, 2], 201)

    assert :amount_error =
             TicketMaker.V1.make_nishatan([1, 2], 10)

    assert :key_error =
             TicketMaker.V1.make_nishatan([1, 0], 100)

    assert :key_error =
             TicketMaker.V1.make_nishatan([1, 1], 100)

    assert :key_error =
             TicketMaker.V1.make_nishatan([1], 100)
  end

  test "make_sanrentan/2" do
    assert %{"type" => 2, "first" => [1], "second" => [2], "third" => [3], "unitQuantity" => 1} =
             TicketMaker.V1.make_sanrentan([1, 2, 3], 100)

    assert :amount_error =
             TicketMaker.V1.make_sanrentan([1, 2, 3], 10)

    assert :key_error =
             TicketMaker.V1.make_sanrentan([1, 2, 0], 100)

    assert :key_error =
             TicketMaker.V1.make_sanrentan([1, 2, 1], 100)

    assert :key_error =
             TicketMaker.V1.make_sanrentan([1, 2], 100)
  end
end
