defmodule Day02 do
  def get_keypad(part) do
    case part do
      :part_1 ->
        # 1 2 3
        # 4 5 6
        # 7 8 9
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

      :part_2 ->
        #     1
        #   2 3 4
        # 5 6 7 8 9
        #   A B C
        #     D
        [
          %{key: 1, down: 3},
          %{
            key: 2,
            down: 6,
            right: 3
          },
          %{
            key: 3,
            up: 1,
            down: 7,
            left: 2,
            right: 4
          },
          %{
            key: 4,
            down: 8,
            left: 3
          },
          %{
            key: 5,
            right: 6
          },
          %{
            key: 6,
            up: 2,
            down: "A",
            left: 5,
            right: 7
          },
          %{
            key: 7,
            up: 3,
            down: "B",
            left: 6,
            right: 8
          },
          %{
            key: 8,
            up: 4,
            down: "C",
            left: 7,
            right: 9
          },
          %{
            key: 9,
            left: 8
          },
          %{
            key: "A",
            up: 6,
            right: "B"
          },
          %{
            key: "B",
            up: 7,
            down: "D",
            left: "A",
            right: "C"
          },
          %{
            key: "C",
            up: 8,
            left: "B"
          },
          %{key: "D", up: "B"}
        ]
    end
  end

  def solve(filename, part) do
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
    |> process_instructions(part)
  end

  def process_instructions(instructions, part) do
    process_instructions(instructions, "5", part)
  end

  def process_instructions([], "5" <> passcode, _part) do
    passcode
  end

  def process_instructions([next_line | rest], passcode, part) do
    start_key =
      passcode
      |> String.last()
      |> char_to_integer()

    next_key =
      process_instruction(next_line, start_key, part)

    process_instructions(rest, passcode <> integer_to_char(next_key), part)
  end

  def char_to_integer(char) do
    if String.match?(char, ~r/^\d+$/) do
      String.to_integer(char)
    else
      char
    end
  end

  def integer_to_char(char) do
    cond do
      Kernel.is_integer(char) -> Integer.to_string(char)
      true -> char
    end
  end

  def process_instruction([], current_key, _part) do
    current_key
  end

  def process_instruction([instruction | rest], current_key, part) do
    keypad = get_keypad(part)

    key = Enum.find(keypad, fn x -> x.key == current_key end)

    next_key = Map.get(key, instruction, current_key)

    process_instruction(rest, next_key, part)
  end
end
