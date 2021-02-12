defmodule Vat do
  @moduledoc """
  Elixir In Action book example for function overloading
  """
  def price(%{country: :germany, price: price}), do: 1.19 * price
  def price(%{country: :greece, price: price}), do: 1.24 * price
  def price(%{country: :croatia, price: price}), do: 1.25 * price
end
