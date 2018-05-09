defmodule FuckFlakeTest do
  use ExUnit.Case
  doctest FuckFlake

  test "greets the world" do
    assert FuckFlake.hello() == :world
  end
end
