defmodule Day01 do
  def part_1(filename) do
    filename
    |> get_directions()
    |> process_directions()
    |> Enum.map(&abs/1)
    |> Enum.sum()
  end

  def process_directions([], [x, y, _], _visited_positions) do
    [x, y]
  end

  def process_directions(directions, curr_position, visited_positions) do
    [next_direction | remaining] = directions

    next_position = next_position(next_direction, curr_position)

    [currx, curry, _] = curr_position

    new_visited =
      case next_position do
        [nx, _ny, :east] ->
          1..(nx - currx)
          |> Enum.map(fn b -> [currx + b, curry] end)

        [nx, _ny, :west] ->
          1..(currx - nx)
          |> Enum.map(fn b -> [currx - b, curry] end)

        [_nx, ny, :north] ->
          1..(ny - curry)
          |> Enum.map(fn b -> [currx, curry + b] end)

        [_nx, ny, :south] ->
          1..(curry - ny)
          |> Enum.map(fn b -> [currx, curry - b] end)
      end

    [_, _, new_orientation] = next_position

    new_visited
    |> Enum.find(fn pos -> Enum.member?(visited_positions, pos) end)
    |> case do
      [x, y] ->
        # we've been here before! stop processing directions!
        process_directions([], [x, y, new_orientation], [])

      _ ->
        # we haven't returned to any previous positions, continue processing directions
        process_directions(remaining, next_position, new_visited ++ visited_positions)
    end
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
    process_directions(directions, [0, 0, :north], [[0, 0]])
  end

  def get_directions(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
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
