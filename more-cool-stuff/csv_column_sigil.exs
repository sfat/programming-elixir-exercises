defmodule CsvSigil do
  
  def sigil_v(lines, _opts) do
    lines
    |> String.trim_trailing
    |> String.split("\n")
    |> Enum.map(&String.split(&1,","))
    |> Enum.map(&convert_numbers/1)
    |> display
  end
  
  def display([header | rows]) do
    [item, qty, price] = header
    |> Enum.map(&String.to_atom/1)
    
    for [i, q, p] <- rows, into: [] do
      [{item, i}, {qty, q}, {price, p}]
    end
  end  
  def convert_numbers(list) do
    list
    |> Enum.map(&convert_to_number/1)
  end

  def convert_to_number(string) do
    case Float.parse(string) do
      {number, _rest} -> number
      :error -> string
      _ -> string
    end
  end
end

defmodule Example do
  import CsvSigil
  def csv do
    ~v"""
    Item,Qty,Price
    Teddy Bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """
  end
end

IO.inspect(Example.csv)