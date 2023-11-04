defmodule Day04 do
  def part_1(filename) do
    filename
    |> get_valid_rooms()
    |> Stream.map(fn {_, sector, _, _} ->
      sector
    end)
    |> Enum.sum()
  end

  def get_valid_rooms(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&String.split_at(&1, -7))
    |> Stream.map(fn {room_and_sector, checksum} ->
      {room, sector} = String.split_at(room_and_sector, -4)
      "-" <> sector = sector

      checksum =
        checksum
        |> String.trim("[")
        |> String.trim("]")

      room =
        room
        |> String.replace("-", "")
        |> String.graphemes()
        |> Enum.frequencies()
        |> Enum.sort_by(fn {_, v} -> -v end)
        |> Enum.take(5)
        |> Enum.map(fn {k, _} -> k end)
        |> Enum.join()

      sector =
        sector
        |> String.to_integer()

      {room, sector, checksum, room_and_sector}
    end)
    |> Stream.filter(fn {room, _, checksum, _} ->
      room == checksum
    end)
  end

  def part_2(filename) do
    filename
    |> get_valid_rooms()
    |> Stream.map(fn {_, sector, _, room_and_sector} ->
      {room, _} = String.split_at(room_and_sector, -4)

      parsed =
        room
        |> String.graphemes()
        |> Enum.map(fn character ->
          shift_char(character, sector)
        end)
        |> Enum.join()

      {parsed, sector}
    end)
    |> Stream.filter(fn {parsed, _sector} ->
      parsed
      |> String.contains?("north")
    end)
    |> Enum.to_list()
  end

  @alphabet "abcdefghijklmnopqrstuvwxyz" |> String.graphemes()

  def shift_char("-", _), do: "-"

  def shift_char(character, shift_count) do
    char_index =
      @alphabet
      |> Enum.find_index(&(&1 == character))

    target_index =
      char_index
      |> Kernel.+(shift_count)
      |> Kernel.rem(26)

    @alphabet
    |> Enum.at(target_index)
  end
end
