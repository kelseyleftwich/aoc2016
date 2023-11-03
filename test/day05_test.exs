defmodule Day05Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day05.part_1("abc") == "18f47a30"
  end

  test "part 1 - input 1" do
    assert Day05.part_1("ffykfhsq") == "c6697b55"
  end
end
