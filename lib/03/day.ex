defmodule Day03 do
  def solve(filename) do
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

  defp split_every_5_chars(""), do: []

  defp split_every_5_chars(str) do
    case String.split_at(str, 5) do
      {chunk, rest} -> [chunk | split_every_5_chars(rest)]
    end
  end
end
