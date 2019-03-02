defmodule CsvSigil do
  def sigil_v(lines, _opts) do
    lines
    |> String.trim_trailing
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end
end

defmodule Example do
  import CsvSigil
  def csv do
    ~v"""
    1,2,3
    cat,dog
    """
  end
end

IO.inspect(Example.csv)