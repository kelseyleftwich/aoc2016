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

  def part_2(door_id) do
    part_2(door_id, 0, [nil, nil, nil, nil, nil, nil, nil, nil])
  end

  def part_2(_door_id, _iter, passcode)
      when is_binary(passcode) and byte_size(passcode) == 8 do
    passcode
  end

  def part_2(door, iter, passcode) do
    passcode
    |> Enum.any?(fn char -> char == nil end)
    |> case do
      true ->
        code = "#{door}#{iter}"

        passcode =
          :crypto.hash(:md5, code)
          |> Base.encode16(case: :lower)
          |> String.slice(0..6)
          |> case do
            "00000" <> chars ->
              [pos_char, insert_char] =
                chars |> String.graphemes()

              case Integer.parse(pos_char) do
                :error ->
                  passcode

                {pos_char, _} ->
                  if Enum.at(passcode, pos_char) == nil do
                    passcode
                    |> List.replace_at(pos_char, insert_char)
                  else
                    passcode
                  end
              end

            _ ->
              passcode
          end

        part_2(door, iter + 1, passcode)

      false ->
        passcode |> Enum.join()
    end
  end
end
