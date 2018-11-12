defmodule GeneralStore do
  def test_data do
    [
      %{title: "Longsword", price: 50, magic: false},
      %{title: "Healing Potion", price: 60, magic: true},
      %{title: "Rope", price: 10, magic: false},
      %{title: "Dragon's Spear", price: 100, magic: true}
    ]
  end

  def filter_items([], _), do: []
  def filter_items([item = %{magic: item_magic} | tail], magic: magic)
  when item_magic == magic do
    [item | filter_items(tail, magic: magic)]
  end
  def filter_items([_ | tail], magic: magic) do
    filter_items(tail, magic: magic)
  end
  
end
