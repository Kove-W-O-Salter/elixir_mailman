defmodule ElixirMailmanTest do
  use ExUnit.Case
  doctest ElixirMailman

  test "greets the world" do
    assert ElixirMailman.hello() == :world
  end
end
