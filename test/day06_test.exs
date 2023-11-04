defmodule Day06Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day06.part_1("example.txt", :example) == "easter"
  end

  test "part 1 - input" do
    assert Day06.part_1("input.txt", :input) == "tzstqsua"
  end
end
