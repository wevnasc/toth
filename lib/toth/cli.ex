defmodule Toth.CLI do

  def main(args) do
    {parsed, args, invalid} = OptionParser.parse(
      args,
      switches: [chars: nil, lines: nil, words: nil],
      aliases: [c: :chars, l: :lines, w: :words])

    IO.inspect {parsed, args, invalid}
  end

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

  def process(text, flags) do
    Enum.map(flags, fn flag ->
      {flag, split_by(flag, text) |> Enum.count}
    end)
  end

end
