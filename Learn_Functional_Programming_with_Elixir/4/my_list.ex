defmodule MyList do
  def max([]), do: nil
  def max([a]), do: a
  def max([a, b | tail]) do
    if a > b do
      max [a | tail]
    else
      max [b | tail]
    end
  end

  def min([]), do: nil
  def min([a]), do: a
  def min([a, b | tail]) do
    if a < b do
      min [a | tail]
    else
      min [b | tail]
    end
  end
end
