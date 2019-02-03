defmodule MyList do
  def flatten([]), do: []

  def flatten([head | tail]) when is_number(head) do
    [head | flatten(tail)]
  end

  def flatten([head | tail]) when is_list(head) do
    flatten(head) ++ flatten(tail)
  end
end
