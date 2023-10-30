defmodule Day01 do
  def part_1(filename) do
    filename
    |> get_directions()
    |> process_directions()
    |> Enum.map(&abs/1)
    |> Enum.sum()
  end

  def process_directions([], [x, y, _]) do
    [x, y]
  end

  def process_directions(directions, [x, y, oriented]) do
    [next_direction | remaining] = directions

    process_directions(remaining, next_position(next_direction, [x, y, oriented]))
  end

  def next_position({:right, blocks}, [x, y, oriented]) do
    case oriented do
      :north ->
        [x + blocks, y, :east]

      :east ->
        [x, y - blocks, :south]

      :south ->
        [x - blocks, y, :west]

      :west ->
        [x, y + blocks, :north]
    end
  end

  def next_position({:left, blocks}, [x, y, oriented]) do
    case oriented do
      :north ->
        [x - blocks, y, :west]

      :west ->
        [x, y - blocks, :south]

      :south ->
        [x + blocks, y, :east]

      :east ->
        [x, y + blocks, :north]
    end
  end

  def process_directions(directions) do
    process_directions(directions, [0, 0, :north])
  end

  def get_directions(filename) do
    cwd = Path.dirname(__ENV__.file)
    full_path = Path.join(cwd, filename)

    full_path
    |> File.stream!()
    |> Enum.take(1)
    |> List.first()
    |> String.trim()
    |> String.split(", ")
    |> Enum.map(&parse_direction/1)
  end

  def parse_direction("R" <> blocks) do
    {:right, String.to_integer(blocks)}
  end

  def parse_direction("L" <> blocks) do
    {:left, String.to_integer(blocks)}
  end
end
