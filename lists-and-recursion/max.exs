defmodule MyList do
    def max([]), do: 0
    def max([head | tail]), do: max_acc(head, tail)

    defp max_acc(max, []), do: max
    defp max_acc(max, [head | tail]) when head > max, do: max_acc(head, tail)
    defp max_acc(max, [head | tail]) when head < max, do: max_acc(max, tail) 
end
