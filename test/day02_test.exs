defmodule Day02Test do
  use ExUnit.Case

  test "example 1" do
    assert Day02.solve("example1.txt") === "1985"
  end

  test "part 1 solve" do
    assert Day02.solve("input.txt") === "73597"
  end
end
