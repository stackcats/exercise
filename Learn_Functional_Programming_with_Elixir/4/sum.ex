defmodule Sum do
  def up_to(n) when n <= 0, do: 0
  def up_to(n), do: up_to(n, 0)
  def up_to(0, acc), do: acc
  def up_to(n, acc) do
    up_to(n - 1, acc + n)  
  end

end
