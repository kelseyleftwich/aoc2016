defmodule Day09 do
  def solve(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Enum.to_list()
    |> List.first()
    |> decompress_line()
    |> String.length()
  end

  def decompress_line(line) do
    decompress_line(line, "")
  end

  def decompress_line("", decompressed) do
    decompressed
  end

  def decompress_line("(" <> line, decompressed) do
    [marker, rest] =
      line
      |> String.split(")", parts: 2)

    [char_count, repeats] =
      marker
      |> String.split("x", parts: 2)
      |> Enum.map(&String.to_integer/1)

    {chars_to_repeat, rest} =
      rest
      |> String.split_at(char_count)

    # comment out next line for part 1
    chars_to_repeat = chars_to_repeat |> decompress_line()

    updated =
      "#{decompressed}#{String.duplicate(chars_to_repeat, repeats)}"

    decompress_line(rest, updated)
  end

  def decompress_line(line, decompressed) do
    {first, rest} = line |> String.split_at(1)

    decompress_line(rest, "#{decompressed}#{first}")
  end
end
