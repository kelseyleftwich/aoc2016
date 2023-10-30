defmodule Day01Test do
  use ExUnit.Case

  test "example 1" do
    assert Day01.part_1("example1.txt") === 5
  end

  test "example 2" do
    assert Day01.part_1("example2.txt") === 2
  end

  test "example 3" do
    assert Day01.part_1("example3.txt") === 12
  end

  test "input" do
    assert Day01.part_1("input.txt") === 242
  end
end
