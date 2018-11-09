defmodule MatchstickFactory do
  @big_size 50
  @medium_size 20
  @small_size 5
  
  def boxes(n) do
    big = div n, @big_size
    n = rem n, @big_size

    medium = div n, @medium_size
    n = rem n, @medium_size

    small = div n, @small_size
    n = rem n, @small_size
    
    %{big: big, medium: medium, small: small, remaining_matchsticks: n}
  end
end
