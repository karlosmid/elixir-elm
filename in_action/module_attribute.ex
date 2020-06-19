defmodule Croatian.Basketball do
  def position height do
    cond do
      height > 205 -> "center"
      height > 200 -> "forward"
      height > 180 -> "guard"
      true -> Integer.to_string(height)
    end
  end

  def trials height do
    if height > 180 do "invite candidate"
    else "reject candidate"
    end
  end
end
