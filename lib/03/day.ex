defmodule Day03 do
  def part_1(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&split_every_5_chars/1)
    |> Stream.map(
      &Enum.map(&1, fn char ->
        char = String.trim(char)
        String.to_integer(char)
      end)
    )
    |> Stream.map(&Enum.sort/1)
    |> Stream.filter(fn [a, b, c] ->
      a + b > c
    end)
    |> Enum.count()
  end

  def part_2(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&split_every_5_chars/1)
    |> Stream.map(
      &Enum.map(&1, fn char ->
        char = String.trim(char)
        String.to_integer(char)
      end)
    )
    |> Stream.chunk_every(3)
    |> Stream.flat_map(fn [[a1, b1, c1], [a2, b2, c2], [a3, b3, c3]] ->
      [[a1, a2, a3], [b1, b2, b3], [c1, c2, c3]]
    end)
    |> Stream.map(&Enum.sort/1)
    |> Stream.filter(fn [a, b, c] ->
      a + b > c
    end)
    |> Enum.count()
  end

  defp split_every_5_chars(""), do: []

  defp split_every_5_chars(str) do
    case String.split_at(str, 5) do
      {chunk, rest} -> [chunk | split_every_5_chars(rest)]
    end
  end
end
