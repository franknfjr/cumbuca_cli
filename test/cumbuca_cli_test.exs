defmodule CumbucaCliTest do
  use ExUnit.Case
  doctest CumbucaCli

  test "greets the world" do
    assert CumbucaCli.hello() == :world
  end
end
