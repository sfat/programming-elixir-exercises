defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: [BitString] do
  def encrypt(string, shift) do
    string
    |> String.to_charlist
    |> Enum.map(&Char.shift(&1, shift))
    |> List.to_string
  end
  
  def rot13(string) do
    Caesar.encrypt(string, 13)
  end
end

defimpl Caesar, for: [List] do
  def encrypt(string, shift) do
    string
    |> Enum.map(&Char.shift(&1, shift))
  end
  
  def rot13(string) do
    Caesar.encrypt(string, 13)
  end
end

defmodule Char do
  def shift(text, shift) do
    add(text, shift)
  end

  defp add(<<c::utf8>>, shift), do: add(c, shift)
  defp add(c, shift) when c in ?a..?z, do: rem(c - ?a + shift, 26) + ?a
  defp add(c, shift) when c in ?A..?Z, do: rem(c - ?A + shift, 26) + ?A
  defp add(c, _), do: c
end

IO.puts Caesar.encrypt("hello", 7)
IO.puts Caesar.encrypt(["h","e","l","l","o"], 7)

defmodule Words do
  def words_lookup do
    lookup_words = get_lookup_words()
    words = get_my_words()
    find_matches(lookup_words, words)
  end
  
  defp get_lookup_words do
    File.stream!("lookup_words.txt")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, Caesar.rot13(x)) end)
    # |> IO.inspect
  end
  
  defp get_my_words do
    [
      "arneol",
      "znpuvar"
    ]
  end
  
  defp find_matches(lookup_words, words) do
    words
    |> Enum.map(&find_matching_word(&1, lookup_words))
  end
  
  defp find_matching_word(word, lookup_words) do
    lookup_words
    |> Enum.find(fn {k, v} -> v == word end)
    |> IO.inspect
  end
end

Words.words_lookup()