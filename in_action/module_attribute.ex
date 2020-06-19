defmodule Croatian.Basketball do
  @moduledoc "Helps Croatian basketball teams in candidate selection."
  @treshold 180
  @doc "Based on candidate height, determines candidate team position."
  def position height do
    cond do
      height > 205 -> "center"
      height > 200 -> "forward"
      height > @treshold -> "guard"
      true -> Integer.to_string(height)
    end
  end
  @doc "Based on candidate height, invites or rejects candidate."
  def trials height do
    if height > @treshold do "invite candidate"
    else "reject candidate"
    end
  end
end
