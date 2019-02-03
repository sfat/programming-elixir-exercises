defmodule SalesTax do
  def tax_calculate do
    tax_rates = [NC: 0.075, TX: 0.08]
    {:ok, file} = File.open("sales.csv")
    # reading header
    _header = IO.read(file, :line)

    file
    |> IO.stream(:line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Enum.map(fn [id, ship_to, net_amount] ->
      [
        id: String.to_integer(id),
        ship_to: String.replace(ship_to, ":", "") |> String.to_atom(),
        net_amount: String.to_float(net_amount)
      ]
    end)
    |> apply_tax(tax_rates)
  end

  def apply_tax(orders, tax_rates) do
    Enum.map(orders, fn order = [_, ship_to: ship_to, net_amount: net_amount] ->
      # IO.inspect(ship_to == :":NC")
      IO.puts("inside apply_tax:  #{ship_to}  + #{Keyword.get(tax_rates, ship_to)}")

      if Keyword.get(tax_rates, ship_to) == nil do
        order
      else
        order ++ [total_amount: net_amount + Keyword.get(tax_rates, ship_to)]
      end
    end)
  end
end
