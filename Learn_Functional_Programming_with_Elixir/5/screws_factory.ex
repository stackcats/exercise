defmodule ScrewsFactory do
  def run(pieces) do
    pieces
    |> Stream.chunk_every(50)
    |> Stream.flat_map(&add_thread/1)
    |> Stream.chunk_every(50)
    |> Stream.flat_map(&add_head/1)
    |> Stream.chunk_every(30)
    |> Stream.flat_map(&pack/1)
    |> Enum.each(&output/1)
  end

  def add_thread(piece) do
    Process.sleep(50)
    Enum.map(piece, &(&1 <> "--"))
  end

  def add_head(piece) do
    Process.sleep(100)
    Enum.map(piece, &("o" <> &1))
  end

  def pack(piece) do
    Process.sleep(70)
    Enum.map(piece, &("|#{&1}|"))
  end
  
  def output(screw) do
    IO.inspect(screw)
  end
end
