defmodule Day10 do
  def part_1(filename) do
    cwd = Path.dirname(__ENV__.file)

    filename
    |> InputProc.get_file_stream(cwd)
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(%{}, &process_instruction/2)
  end

  def part_2() do
    Day10.part_1("input.txt")
    |> Map.take(["output1", "output2", "output0"])
    |> Enum.map(fn {_id, %{values: values}} -> values end)
    |> List.flatten()
    |> Enum.reduce(1, &*/2)
  end

  def process_instruction(instruction) do
    process_instruction(instruction, %{})
  end

  # bot 2 gives low to bot 1 and high to bot 0
  def process_instruction("bot " <> rest, factory) do
    %{"bot" => bot, "device1" => device1, "low" => low, "device2" => device2, "high" => high} =
      Regex.named_captures(
        ~r/(?<bot>\d+) gives low to (?<device1>(bot|output)) (?<low>\d+) and high to (?<device2>(bot|output)) (?<high>\d+)/,
        rest
      )

    bot = "bot" <> bot

    device1 = "#{device1}#{low}"
    device2 = "#{device2}#{high}"

    factory
    |> Map.update(bot, %{low: device1, high: device2}, fn existing_bot ->
      existing_bot
      |> Map.update(:low, device1, fn _ -> device1 end)
      |> Map.update(:high, device2, fn _ -> device2 end)
    end)
    |> check_factory()
  end

  def process_instruction("value " <> rest, factory) do
    [value, bot] =
      rest
      |> String.split(" goes to bot ")

    bot = "bot" <> bot

    value =
      value
      |> String.to_integer()

    factory
    |> Map.update(bot, %{values: [value]}, fn existing_bot ->
      existing_bot
      |> Map.update(:values, [value], fn existing_values -> [value | existing_values] end)
    end)
    |> check_factory()
  end

  def group_factory(factory) do
    grouped =
      factory
      |> Enum.group_by(fn {_id, rest} ->
        rest
        |> Map.get(:values, [])
        |> Enum.count()
        |> Kernel.>(1)
        |> Kernel.&&(rest |> Map.has_key?(:high))
        |> Kernel.&&(rest |> Map.has_key?(:low))
      end)

    bots_with_less_than_two_values =
      grouped
      |> Map.get(false, [])

    bots_with_two_values = grouped |> Map.get(true, [])

    {bots_with_less_than_two_values, bots_with_two_values}
  end

  def factory_has_bots_with_two_values(factory) do
    {_, bots_with_two_values} = group_factory(factory)

    Enum.count(bots_with_two_values) > 0
  end

  def check_factory(factory) do
    {bots_with_less_than_two_values, bots_with_two_values} =
      group_factory(factory)

    factory =
      bots_with_two_values
      # |> Enum.map(fn bot ->
      #   {id, rest} =
      #     bot

      #   rest
      #   |> Map.get(:values, [])
      #   |> Enum.sort()
      #   |> Kernel.==([17, 61])
      #   |> if do
      #     IO.inspect("FOUND #{id}")
      #     exit("done")
      #   end

      #   bot
      # end)
      |> Enum.reduce(Map.new(bots_with_less_than_two_values), fn {id,
                                                                  %{
                                                                    high: high,
                                                                    low: low,
                                                                    values: values
                                                                  }},
                                                                 acc ->
        [lower, higher] =
          values
          |> Enum.sort()

        acc
        |> Map.update(high, %{values: [higher]}, fn existing_bot ->
          existing_bot
          |> Map.update(:values, [higher], fn existing_values ->
            [higher | existing_values]
          end)
        end)
        |> Map.update(low, %{values: [lower]}, fn existing_bot ->
          existing_bot
          |> Map.update(:values, [lower], fn existing_values ->
            [lower | existing_values]
          end)
        end)
        |> Map.update(id, %{values: [], high: high, low: low}, fn existing_bot ->
          existing_bot
          |> Map.update(:values, [], fn _ -> [] end)
        end)
      end)

    if(factory_has_bots_with_two_values(factory)) do
      check_factory(factory)
    else
      factory
    end
  end
end
