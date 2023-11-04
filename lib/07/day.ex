defmodule Day07 do
  def solve(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line ->
      parts =
        line
        |> String.replace("]", "[")
        |> String.split("[")

      unwrapped =
        parts
        |> Enum.take_every(2)

      wrapped =
        parts
        |> tl()
        |> Enum.take_every(2)

      [unwrapped, wrapped]
    end)
    |> Stream.map(fn [unwrapped, wrapped] ->
      unwrapped_valid =
        unwrapped
        |> Enum.any?(&has_abba/1)

      wrapped_valid =
        wrapped
        |> Enum.any?(&has_abba/1)
        |> Kernel.not()

      [unwrapped_valid, wrapped_valid]
    end)
    |> Stream.filter(fn [unwrapped_valid, wrapped_valid] ->
      unwrapped_valid && wrapped_valid
    end)
    |> Enum.count()
  end

  def filter_abba([_, true, _]) do
    false
  end

  def filter_abba([true, _, _]), do: true
  def filter_abba([_, _, true]), do: true
  def filter_abba([_, _, _]), do: false

  def has_abba(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.map(fn [a, b, c, d] ->
      a == d && b == c && a != b
    end)
    |> Enum.any?(fn x -> x end)
  end
end
