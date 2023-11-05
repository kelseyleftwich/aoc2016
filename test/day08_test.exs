defmodule Day08Test do
  use ExUnit.Case

  test "part 1 - example" do
    assert Day08.solve("example.txt", :example) == 6
  end

  test "part 1 - input" do
    assert Day08.solve("input.txt", :input) == 123
  end
end
