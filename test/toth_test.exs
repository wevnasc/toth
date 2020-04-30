defmodule TothTest do
  use ExUnit.Case
  doctest Toth

  test "greets the world" do
    assert Toth.hello() == :world
  end
end
