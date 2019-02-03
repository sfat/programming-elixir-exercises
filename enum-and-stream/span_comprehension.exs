defmodule PrimeNumbersWithSpan do
  def prime_numbers(n) do
    for x <- span(2, n),
        Enum.all?(
          span(2, Enum.max([1, x - 1])),
          fn v -> rem(x, v) > 0 end
        ),
        do: x
  end

  def span(from, to) when from > to and is_number(from) and is_number(to), do: []

  def span(from, to) when from <= to and is_number(from) and is_number(to),
    do: [from | span(from + 1, to)]
end
