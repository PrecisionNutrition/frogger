defmodule FroggerTest do
  use ExUnit.Case
  doctest Frogger

  test "gets all roles" do
    assert Frogger.get_roles() == :world
  end
end
