defmodule JiraConnectTest do
  use ExUnit.Case
  doctest JiraConnect

  test "greets the world" do
    assert JiraConnect.hello() == :world
  end
end
