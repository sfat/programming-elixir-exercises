dave = %{name: "Dave", age: 27}

case dave do
  person = %{age: age} when is_number(age) and age >= 21 ->
    IO.puts("You are cleared to enter to Foo Bar, #{person.name}")

  _ ->
    IO.puts("Sorry, no admission")
end
