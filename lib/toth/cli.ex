defmodule Toth.CLI do

  def split_by(:words, text) do
    text
    |> String.trim
    |> String.replace(~r{\d|[^\w\s']}, "")
    |> String.split(~r{\s})
    |> Enum.filter(&(&1 != ""))
  end

  def split_by(:lines, text) do
    text
    |> String.trim
    |> String.split(~r{\n})
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&(String.trim(&1)))
  end

  def split_by(:chars, text) do
    text
    |> String.trim
    |> String.split("")
    |> Enum.map(&(String.trim(&1)))
    |> Enum.filter(&(&1 != ""))
  end

  def process(text, flags) do
    Enum.map(flags, fn {flag, _} ->
      {flag, split_by(flag, text) |> Enum.count}
    end)
  end

  def show(output) do
    Enum.reduce(output, "", fn ({flag, value}, acc) ->
      acc <> "#{flag} => #{value}\n"
    end)
    |> IO.puts
  end

  def show_help() do
    IO.puts """
    TOTH HELP!

    you can use the following commands:

    -c to show the chars quantity
    -l to show the lines quantity
    -w to show the words quantity

    example:
    toth "file path" -c -l -w
    """
  end

  def start([], _), do: show_help()

  def start([file_path|_], flags) do
    File.read!(file_path)
    |> process(flags)
    |> show
  end

  def main(args) do
    {parsed, args, invalid} = OptionParser.parse(
      args,
      switches: [chars: nil, lines: nil, words: nil, help: nil],
      aliases: [c: :chars, l: :lines, w: :words, h: :help])

    if not Enum.member?(parsed, {:help, true}) and Enum.empty?(invalid) do
      start(args, parsed)
    else
      show_help()
    end

  end

end
