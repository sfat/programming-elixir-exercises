defmodule LengthList do
    def of([]), do: 0
    def of([_|tail]), do: 1 + of(tail)
end
