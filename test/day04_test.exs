defmodule Day04Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day04.part_1("example.txt") === 1514
  end

  test "part 1 - input 1" do
    assert Day04.part_1("input.txt") === 173_787
  end
end
