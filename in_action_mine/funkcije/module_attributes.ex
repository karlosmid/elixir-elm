defmodule Circle do
  @pi 3.14159

  @spec area(number) :: number
  def area(r), do: r*r*@pi

  @spec circumferance(number) :: number
  def circumferance(r), do: 2*r*@pi
end
