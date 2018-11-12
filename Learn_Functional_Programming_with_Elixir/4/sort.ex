defmodule Sort do
  def descending([]), do: []
  def descending([a]), do: [a]
  def descending(xs) do
    half_size = div(Enum.count(xs), 2)
    {left, right} = Enum.split(xs, half_size)
    p = &>/2
    merge(descending(left), descending(right), p)
  end

  def ascending([]), do: []
  def ascending([a]), do: [a]
  def ascending(xs) do
    half_size = div(Enum.count(xs), 2)
    {left, right} = Enum.split(xs, half_size)
    p = &</2
    merge(ascending(left), ascending(right), p)
  end

  defp merge([], ys, _), do: ys
  defp merge(xs, [], _), do: xs
  defp merge([x | xs], [y | ys], p) do
    if p.(x, y) do
      [x | merge(xs, [y | ys], p)]
    else
      [y | merge([x | xs], ys, p)]
    end
  end
end
