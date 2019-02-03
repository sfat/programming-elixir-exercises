defmodule FizzBuzz do
  def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

  defp fizzbuzz(n), do: _fizzbuzz(n, rem(n, 3), rem(n, 5))
  defp _fizzbuzz(_, 0, 0), do: "FizzBuzz"
  defp _fizzbuzz(_, 0, _), do: "Fizz"
  defp _fizzbuzz(_, _, 0), do: "Buzz"
  defp _fizzbuzz(n, _, _), do: n
end
