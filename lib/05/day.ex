defmodule Day05 do
  def part_1(door_id) do
    part_1(door_id, 0, "")
  end

  def part_1(_door_id, _iter, passcode)
      when is_binary(passcode) and byte_size(passcode) == 8 do
    passcode
  end

  def part_1(door, iter, passcode) do
    code = "#{door}#{iter}"

    passcode =
      :crypto.hash(:md5, code)
      |> Base.encode16(case: :lower)
      |> String.slice(0..5)
      |> case do
        "00000" <> char ->
          "#{passcode}#{char}"

        _ ->
          passcode
      end

    part_1(door, iter + 1, passcode)
  end
end
