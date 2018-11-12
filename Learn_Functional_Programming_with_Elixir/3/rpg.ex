defmodule RPG do
  def points(%{strength: s, dexterity: d, intelligence: i}) do
    s * 2 + d * 3 + i + 3
  end
end
