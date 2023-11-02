defmodule Day03Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day03.solve("example.txt") === 0
  end

  test "part 1 - input" do
    assert Day03.solve("input.txt") === 983
  end
end
