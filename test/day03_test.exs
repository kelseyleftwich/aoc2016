defmodule Day03Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day03.part_1("example.txt") === 0
  end

  test "part 1 - input" do
    assert Day03.part_1("input.txt") === 983
  end

  test "part 2 - example 2" do
    assert Day03.part_2("example2.txt") === 6
  end

  test "part 2 - input " do
    assert Day03.part_2("input.txt") === 1836
  end
end
