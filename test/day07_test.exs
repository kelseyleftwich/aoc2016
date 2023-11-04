defmodule Day07Test do
  use ExUnit.Case

  test "part 1 - example" do
    assert Day07.part_1("example.txt") == 2
  end

  test "part 1 - input" do
    assert Day07.part_1("input.txt") == 115
  end

  test "part 2 - example " do
    assert Day07.part_2("example2.txt") == 3
  end

  test "part 2 - input " do
    assert Day07.part_2("input.txt") == 231
  end
end
