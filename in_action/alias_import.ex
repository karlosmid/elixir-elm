defmodule Croatian.Basketball do
  def position height do
    cond do
      height > 205 -> "center"
      height > 200 -> "forward"
      height -> "guard"
    end
  end
end
