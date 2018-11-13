defmodule Quicksort do
  def run([]), do: []
  def run([x]), do: [x]
  def run([x|xs]) do
    {smaller, larger} = Enum.split_with(xs, &(&1 < x))
    run(smaller) ++ [x] ++ run(larger)
  end
end
