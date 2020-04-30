defmodule Toth.CLITest do
  use ExUnit.Case
  doctest Toth.CLI

  test "should return a list with the words in a string" do
    assert Toth.CLI.split_by(:words, "all text here") == ["all", "text", "here"]
    assert Toth.CLI.split_by(:words, "2020 was a great year") == ["was", "a", "great", "year"]
    assert Toth.CLI.split_by(:words, "john's car") == ["john's", "car"]
    assert Toth.CLI.split_by(:words, "remove the points. and , as well") == ["remove", "the", "points", "and", "as", "well"]
    assert Toth.CLI.split_by(:words, "some @ strange char &") == ["some", "strange", "char"]
  end

  test "should return a list with the line in a string" do
    assert Toth.CLI.split_by(:lines, """
      first line
      second line
      last line
    """) == ["first line", "second line", "last line"]

    assert Toth.CLI.split_by(:lines, """
      2020 is the year
      my email is some@example.com
      thanks :D
    """) == ["2020 is the year", "my email is some@example.com", "thanks :D"]
  end

  test "should return quantity by flag" do
    assert Toth.CLI.process("how many items here", [:words]) == [{:words, 4}]
  end
end
