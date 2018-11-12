defmodule Math do
  def sum([]), do: 0
  def sum([], acc), do: acc
  def sum(xs), do: sum(xs, 0)
  def sum([x|xs], acc), do: sum(xs, acc + x)
end
