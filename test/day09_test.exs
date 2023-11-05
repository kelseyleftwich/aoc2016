defmodule Day09Test do
  use ExUnit.Case

  test "part 1 - input" do
    # comment out line 36 in Day09 to test part 1
    assert Day09.solve("input.txt") == 102_239
  end

  test "part 2 - input" do
    assert Day09.solve("input.txt") == 10_780_403_063
  end
end
