defmodule Day06 do
  def part_1(filename, variant) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.graphemes/1)
    |> reduce_chars(variant)
    |> Enum.map(fn {k, v} ->
      [{most_frequent, _}] =
        v
        |> Enum.frequencies()
        |> Enum.sort(fn {_, a}, {_, b} -> a > b end)
        |> Enum.take(1)

      {k, most_frequent}
    end)
    |> Enum.to_list()
    |> Enum.sort(fn {a, _}, {b, _} -> a < b end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.join()
  end

  def reduce_chars(chars_stream, :example) do
    chars_stream
    |> Enum.reduce(%{}, fn [a, b, c, d, e, f], acc ->
      acc
      |> Map.update(:a, [a], &(&1 ++ [a]))
      |> Map.update(:b, [b], &(&1 ++ [b]))
      |> Map.update(:c, [c], &(&1 ++ [c]))
      |> Map.update(:d, [d], &(&1 ++ [d]))
      |> Map.update(:e, [e], &(&1 ++ [e]))
      |> Map.update(:f, [f], &(&1 ++ [f]))
    end)
  end

  def reduce_chars(chars_stream, :input) do
    chars_stream
    |> Enum.reduce(%{}, fn [a, b, c, d, e, f, g, h], acc ->
      acc
      |> Map.update(:a, [a], &(&1 ++ [a]))
      |> Map.update(:b, [b], &(&1 ++ [b]))
      |> Map.update(:c, [c], &(&1 ++ [c]))
      |> Map.update(:d, [d], &(&1 ++ [d]))
      |> Map.update(:e, [e], &(&1 ++ [e]))
      |> Map.update(:f, [f], &(&1 ++ [f]))
      |> Map.update(:g, [g], &(&1 ++ [g]))
      |> Map.update(:h, [h], &(&1 ++ [h]))
    end)
  end
end
