defmodule IntroToSoftwareTesting do
  @moduledoc """
  Supports exercises from the book Introduction To Sofware Testing
  """
  @doc """
  union returns list of elements that are present in either input list
  """
  @spec union(list(), list()) :: list()
  def union(a, b) when is_list(a) and is_list(b) do
    a ++ b |> Enum.uniq()
  end
  def union(_a, _b), do: {:error, "input paramaters must be a list."}
end
