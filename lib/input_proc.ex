defmodule InputProc do
  def get_file_stream(filename, cwd) do
    full_path = Path.join(cwd, filename)

    full_path
    |> File.stream!()
  end
end
