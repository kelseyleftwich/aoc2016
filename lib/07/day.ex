defmodule Day07 do
  def part_1(filename) do
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

  def part_2(filename) do
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

      {unwrapped, wrapped}
    end)
    |> Stream.map(fn {unwrapped, wrapped} ->
      unwrapped =
        unwrapped
        |> get_palindromes()

      wrapped =
        wrapped
        |> get_palindromes()

      {unwrapped, wrapped}
    end)
    |> Stream.filter(fn {unwrapped, wrapped} ->
      wrapped =
        wrapped
        |> Enum.map(fn {a, b} ->
          {b, a}
        end)

      wrapped
      |> Enum.any?(fn {a, b} ->
        unwrapped
        |> Enum.any?(fn {c, d} ->
          a == c && b == d
        end)
      end)
    end)
    |> Enum.count()
  end

  def get_palindromes(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.filter(fn [a, b, c] ->
        a == c && a != b
      end)
      |> Enum.map(fn [a, b, _] ->
        {a, b}
      end)
      |> Enum.uniq()
    end)
    |> Enum.filter(fn x -> x != [] end)
    |> Enum.concat()
    |> Enum.uniq()
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
