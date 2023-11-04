defmodule Day05Test do
  use ExUnit.Case

  test "part 1 - example 1" do
    assert Day05.part_1("abc") == "18f47a30"
  end

  test "part 1 - input 1" do
    assert Day05.part_1("ffykfhsq") == "c6697b55"
  end

  test "part 2 - example 1" do
    assert Day05.part_2("abc") == "05ace8e3"
  end

  test "part 2 - input 1" do
    assert Day05.part_2("ffykfhsq") == "8c35d1ab"
  end
end
