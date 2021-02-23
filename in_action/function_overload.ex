defmodule Vat do
  @moduledoc """
  Elixir In Action book example for function overloading
  """
  def price(%{country: :germany, price: price}), do: calc_total_price(1.19, price)
  def price(%{country: :greece, price: price}), do: calc_total_price(1.24, price)
  def price(%{country: :croatia, price: price}), do: calc_total_price(1.25, price)
  def price(unknown), do: {:unknown_country_data, unknown}

  defp calc_total_price(vat, price) when vat > 1.20, do: "Expensive country: " <> "#{vat * price}"
  defp calc_total_price(vat, price), do: vat * price
end
