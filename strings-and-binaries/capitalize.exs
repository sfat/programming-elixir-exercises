defmodule MyString do
  @sentence_delimiter ". "
  def capitalize_sentences(string) do
    string
    |> String.split(@sentence_delimiter)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(@sentence_delimiter)
  end
end
