defmodule IntroToSoftwareTesting.FaultyPrograms do
  @moduledoc """
  Supports exercises from the book Introduction To Sofware Testing, section 1.2
  """
  @doc """
  findLast returns index of last element in x list that is equal to y.
  If there is no such element, returns -1
  """
  @spec findLast(list(), integer()) :: integer()
  def findLast(x, y), do: findLastRecursive(x, y, 0)
  defp findLastRecursive([], _y, _index), do: -1
  defp findLastRecursive([head | _tail] = _x, y, index) when head == y, do: index
  defp findLastRecursive([_head | tail] = _x, y, index), do: findLastRecursive(tail, y, index + 1)

  @doc """
  lastZero returns index of last zero element in x.
  If there is no such element, returns -1
  """
  @spec lastZero(list()) :: integer()
  def lastZero(x), do: lastZeroRecursive(x, 0)
  defp lastZeroRecursive([], _index), do: -1
  defp lastZeroRecursive([head | _tail] = _x, index) when head == 0, do: index
  defp lastZeroRecursive([_head | tail] = _x, index), do: lastZeroRecursive(tail, index + 1)

  @doc """
  countPositive returns number of positive elements in x.
  """
  @spec countPositive(list()) :: integer()
  def countPositive(x), do: countPositiveRecursive(x, 0)
  defp countPositiveRecursive([], count), do: count
  defp countPositiveRecursive([head | tail] = _x, count) when head >= 0, do: countPositiveRecursive(tail, count + 1)
  defp countPositiveRecursive([_head | tail] = _x, count), do: countPositiveRecursive(tail, count)

  @doc """
  countOddOrPositive returns number of odd or positive elements in x.
  """
  @spec countOddOrPositive(list()) :: integer()
  def countOddOrPositive(x), do: countOddOrPositiveRecursive(x, 0)
  defp countOddOrPositiveRecursive([], count), do: count
  defp countOddOrPositiveRecursive([head | tail] = _x, count) when head >= 0 or rem(head,2) == 1, do: countOddOrPositiveRecursive(tail, count + 1)
  defp countOddOrPositiveRecursive([_head | tail] = _x, count), do: countOddOrPositiveRecursive(tail, count)
end
