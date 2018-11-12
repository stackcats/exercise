defmodule Tax do
  def total(salary) when salary <= 2000, do: 0
  def total(salary) when salary <= 3000, do: salary * 0.05
  def total(salary) when salary <= 6000, do: salary * 0.1
  def total(salary), do: salary * 0.15  
end

input = IO.gets "salary: "

res = case Float.parse input do
        :error -> "something wrong"
        {salary, _} ->
          tax = Tax.total salary
          "Net wage: #{salary - tax} - tax: #{tax}"
      end

IO.puts res
