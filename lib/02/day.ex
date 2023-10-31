defmodule Day02 do
  def solve(filename) do
    cwd = Path.dirname(__ENV__.file)

    instructions =
      filename
      |> InputProc.get_file_stream(cwd)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)
      |> Enum.to_list()

    instructions
    |> process_instructions()
  end

  def process_instructions(instructions) do
    process_instructions(instructions, "5")
  end

  def process_instructions([], "5" <> passcode) do
    passcode
  end

  def process_instructions([next_line | rest], passcode) do
    start_key =
      passcode
      |> String.last()
      |> String.to_integer()

    next_key =
      process_line(next_line, start_key)

    process_instructions(rest, passcode <> Integer.to_string(next_key))
  end

  def process_line([], start_key) do
    start_key
  end

  def process_line([next_step | rest], start_key) do
    next_key =
      process_step(next_step, start_key)

    process_line(rest, next_key)
  end

  def process_step("U", start_key) do
    start_key
    |> Kernel.-(3)
    |> max(min_for_column(start_key))
  end

  def process_step("D", start_key) do
    start_key
    |> Kernel.+(3)
    |> min(max_for_column(start_key))
  end

  def process_step("L", start_key) do
    start_key
    |> Kernel.-(1)
    |> max(min_for_row(start_key))
  end

  def process_step("R", start_key) do
    start_key
    |> Kernel.+(1)
    |> min(max_for_row(start_key))
  end

  def max_for_column(start_key) do
    case start_key do
      1 -> 7
      2 -> 8
      3 -> 9
      4 -> 7
      5 -> 8
      6 -> 9
      7 -> 7
      8 -> 8
      9 -> 9
    end
  end

  def min_for_column(start_key) do
    case start_key do
      1 -> 1
      2 -> 2
      3 -> 3
      4 -> 1
      5 -> 2
      6 -> 3
      7 -> 1
      8 -> 2
      9 -> 3
    end
  end

  def min_for_row(start_key) do
    case start_key do
      1 -> 1
      2 -> 1
      3 -> 1
      4 -> 4
      5 -> 4
      6 -> 4
      7 -> 7
      8 -> 7
      9 -> 7
    end
  end

  def max_for_row(start_key) do
    case start_key do
      1 -> 3
      2 -> 3
      3 -> 3
      4 -> 6
      5 -> 6
      6 -> 6
      7 -> 9
      8 -> 9
      9 -> 9
    end
  end
end

# 1 2 3
# 4 5 6
# 7 8 9

# 5 -> 2
# 6 -> 3
# 4 -> 1
