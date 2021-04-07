ExUnit.start()
defmodule RectangleTest do
  use ExUnit.Case, async: true
  test "tocna povrsina" do
    assert Geometry.Rectangle.area(3,6) == 18
  end
  test "kriva povrsina" do
    assert Geometry.Rectangle.area(4,4) == 16
  end
  test "navodnici povrsina" do
    assert Geometry.Rectangle.area(3,4) == 12
  end
end
