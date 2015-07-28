defmodule SpacedRepetitionsTest do
  use ExUnit.Case

  import SpacedRepetitions, only: [Fact, process_recall: 2]

  test "Fact struct can be created" do
    _ = %Fact{}
  end

  test "New fact can have recall processed" do
    assert process_recall( %Fact{}, 3 )
  end

  test "other scores ..." do
    assert process_recall( %Fact{}, 5 )
  end
end
