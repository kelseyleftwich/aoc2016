defmodule Day02 do
  # 1 2 3
  # 4 5 6
  # 7 8 9

  #     1
  #   2 3 4
  # 5 6 7 8 9
  #   A B C
  #     D
  def get_keypad() do
    [
      %{key: 1, down: 4, right: 2},
      %{key: 2, down: 5, left: 1, right: 3},
      %{key: 3, down: 6, left: 2},
      %{key: 4, up: 1, down: 7, right: 5},
      %{key: 5, up: 2, down: 8, left: 4, right: 6},
      %{key: 6, up: 3, down: 9, left: 5},
      %{key: 7, up: 4, right: 8},
      %{key: 8, up: 5, left: 7, right: 9},
      %{key: 9, up: 6, left: 8}
    ]
  end

  def solve(filename) do
    cwd = Path.dirname(__ENV__.file)

    instructions =
      filename
      |> InputProc.get_file_stream(cwd)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)
      |> Stream.map(fn line ->
        line
        |> Enum.map(fn char ->
          case char do
            "L" ->
              :left

            "R" ->
              :right

            "U" ->
              :up

            "D" ->
              :down
          end
        end)
      end)
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
      process_instruction(next_line, start_key)

    process_instructions(rest, passcode <> Integer.to_string(next_key))
  end

  def process_instruction([], current_key) do
    current_key
  end

  def process_instruction([instruction | rest], current_key) do
    keypad = get_keypad()

    key = Enum.find(keypad, fn x -> x.key == current_key end)

    next_key = Map.get(key, instruction, current_key)

    process_instruction(rest, next_key)
  end
end
