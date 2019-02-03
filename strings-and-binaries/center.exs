defmodule MyString do
  def center(list) do
    max_length = Enum.map(list, &String.length/1) |> Enum.max()

    run_center(list, max_length, &indent1/2)
    IO.puts("")
    run_center(list, max_length, &indent2/2)
  end

  defp run_center(list, max_length, func) do
    Enum.each(list, fn el -> func.(el, max_length) end)
  end

  defp indent1(str, length) do
    dlength = length - String.length(str)
    padding = String.duplicate(" ", div(dlength, 2))
    IO.puts("#{padding}#{str}")
  end

  defp indent2(str, length) do
    len = String.length(str)
    IO.puts(String.pad_leading(str, div(length + len, 2), " "))
  end
end
