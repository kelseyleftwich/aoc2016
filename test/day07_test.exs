defmodule Day07Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day07.solve("example.txt") == 2
  end

  test "part 1 - input" do
    assert Day07.solve("input.txt") == 115
  end
end
