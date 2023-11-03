defmodule Day04 do
  def part_1(filename) do
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

      {room, sector, checksum}
    end)
    |> Stream.filter(fn {room, _, checksum} ->
      room == checksum
    end)
    |> Stream.map(fn {_, sector, _} ->
      String.to_integer(sector)
    end)
    |> Enum.sum()
  end
end
