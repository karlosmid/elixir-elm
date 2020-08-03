defmodule ListRecursion do
  @moduledoc """
  module that demostrates Elixir List Recursion
  """
  @doc """
  Recursivly prints List elements one by one
  """
  def recursion_print(list) do
    do_print(list)
  end
  defp do_print([]), do: IO.puts("Done!")
  defp do_print([h | t]) do
    IO.puts(h)
    do_print(t)
  end
end
