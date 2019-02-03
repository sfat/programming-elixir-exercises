defmodule Anagram do
  def valid?(word1, word2) when length(word1) > length(word2), do: word1 -- word2 == []
  def valid?(word1, word2) when length(word1) <= length(word2), do: word2 -- word1 == []
end
