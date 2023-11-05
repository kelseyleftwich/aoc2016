defmodule Day08 do
  def get_screen(:example) do
    0..2
    |> Enum.map(fn _ ->
      0..6
      |> Enum.map(fn _ ->
        "."
      end)
    end)
  end

  def get_screen(:input) do
    0..5
    |> Enum.map(fn _ ->
      0..49
      |> Enum.map(fn _ ->
        "."
      end)
    end)
  end

  def solve(filename, part) do
    screen =
      get_screen(part)

    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse/1)
    |> Enum.to_list()
    |> Enum.reduce(screen, fn instruction, acc ->
      process(instruction, acc)
    end)
    |> Enum.map(fn row ->
      row
      |> IO.puts()

      row
    end)
    |> List.flatten()
    |> Enum.filter(&(&1 == "#"))
    |> Enum.count()
  end

  def process({:rect, w, h}, screen) do
    0..(h - 1)
    |> Enum.reduce(screen, fn row_index, acc ->
      row =
        acc |> Enum.at(row_index)

      row =
        0..(w - 1)
        |> Enum.reduce(row, fn col, acc1 ->
          acc1
          |> List.replace_at(col, "#")
        end)

      acc |> List.replace_at(row_index, row)
    end)
  end

  def process({:col, x, iters}, screen) do
    col =
      screen
      |> Enum.map(fn row ->
        row
        |> Enum.at(x)
      end)

    col_length =
      col
      |> Enum.count()

    col
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(screen, fn {pixel, index}, acc ->
      new_index =
        (col_length - (index + 1))
        |> Kernel.+(iters)
        |> rem(col_length)

      acc
      |> Enum.with_index()
      |> Enum.map(fn {row, index} ->
        if index == new_index do
          row
          |> List.replace_at(x, pixel)
        else
          row
        end
      end)
    end)
  end

  def process({:row, y, iters}, screen) do
    row =
      screen
      |> Enum.at(y)
      |> shift_forward(iters)

    screen
    |> List.replace_at(y, row)
  end

  def shift_forward(list, positions) do
    end_part = Enum.take(list, -positions)
    start_part = Enum.drop(list, -positions)
    end_part ++ start_part
  end

  # rect AxB
  def parse("rect " <> dimensions) do
    [w, h] =
      dimensions
      |> String.split("x")
      |> Enum.map(&String.to_integer/1)

    {:rect, w, h}
  end

  # rotate row y=A by B
  def parse("rotate row y=" <> rest) do
    [y, iters] =
      rest
      |> String.split(" by ")
      |> Enum.map(&String.to_integer/1)

    {:row, y, iters}
  end

  # rotate column x=A by B
  def parse("rotate column x=" <> rest) do
    [x, iters] =
      rest
      |> String.split(" by ")
      |> Enum.map(&String.to_integer/1)

    {:col, x, iters}
  end
end
