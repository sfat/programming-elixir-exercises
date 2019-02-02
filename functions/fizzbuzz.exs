fizzbuzz = fn
    a = 0, b = 0, _ -> "FizzBuzz"
    a = 0, _, _ -> "Fizz"
    _, b = 0, _ -> "Buzz"
    _, _, c -> c
end

# IO.puts fizzbuzz.(0, 0, 1)
# IO.puts fizzbuzz.(0, 1, 1)
# IO.puts fizzbuzz.(1, 0, 1)
# IO.puts fizzbuzz.(1, 1, 12)

remainder = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

IO.puts remainder.(10)
IO.puts remainder.(11)
IO.puts remainder.(12)
IO.puts remainder.(13)
IO.puts remainder.(14)
IO.puts remainder.(15)
IO.puts remainder.(16)
