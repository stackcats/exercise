defmodule TicTacToe do
  def winner(m) do
    cond do
      check(:x, m) -> {:winner, :x}
      check(:o, m) -> {:winner, :o}
      true -> :no_winner
    end
  end
  
  defp check(a, {a, a, a,
                 _, _, _,
                 _, _, _, }), do: true
  
  defp check(a, {_, _, _,
                 a, a, a,
                 _, _, _, }), do: true
  
  defp check(a, {_, _, _,
                 _, _, _,
                 a, a, a, }), do: true

  defp check(a, {a, _, _,
                 a, _, _,
                 a, _, _, }), do: true

  defp check(a, {_, a, _,
                 _, a, _,
                 _, a, _, }), do: true

  defp check(a, {_, _, a,
                 _, _, a,
                 _, _, a, }), do: true

  defp check(a, {a, _, _,
                 _, a, _,
                 _, _, a, }), do: true

  defp check(a, {_, _, a,
                 _, a, _,
                 a, _, _, }), do: true

  defp check(_, _), do: false
    
end
