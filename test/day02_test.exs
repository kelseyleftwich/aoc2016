defmodule Day02Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day02.solve("example1.txt", :part_1) === "1985"
  end

  test "part 1 - solve" do
    assert Day02.solve("input.txt", :part_1) === "73597"
  end

  test "part 2 - example 1" do
    assert Day02.solve("example1.txt", :part_2) === "5DB3"
  end

  test "part 2 - solve" do
    assert Day02.solve("input.txt", :part_2) === "A47DA"
  end
end
