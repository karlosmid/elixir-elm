defmodule IntroToSoftwareTesting do
  @moduledoc """
  Supports exercises from the book Introduction To Sofware Testing
  """
  @doc """
  union returns list of elements that are present in either input list
  """
  @spec union(list(), list()) :: list()
  def union(a, b) do
    a ++ b |> Enum.uniq()
  end
end
