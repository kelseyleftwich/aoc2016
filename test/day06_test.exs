defmodule Day06Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert ["easter", _] = Day06.part_1("example.txt", :example)
  end

  test "part 1 - input" do
    assert ["tzstqsua", _] = Day06.part_1("input.txt", :input)
  end

  test "part 2 - example 1" do
    assert [_, "advent"] = Day06.part_1("example.txt", :example)
  end

  test "part 2 - input" do
    assert [_, "myregdnr"] = Day06.part_1("input.txt", :input)
  end
end
