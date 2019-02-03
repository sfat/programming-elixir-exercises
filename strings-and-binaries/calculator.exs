defmodule Calculator do
  def calculate(calculation) do
    calculate(calculation, 0, '', 0)
  end

  defp calculate([], lhs, operation, rhs) do
    cond do
      operation == ?+ -> lhs + rhs
      operation == ?- -> lhs - rhs
      operation == ?* -> lhs * rhs
      operation == ?/ -> div(lhs, rhs)
      true -> raise "invalid operation"
    end
  end

  defp calculate([op | tail], lhs, _, rhs) when op == ?+ or op == ?- or op == ?* or op == ?/ do
    calculate(tail, lhs, op, rhs)
  end

  defp calculate([digit | tail], lhs, operation, rhs) when operation != '' do
    calculate(tail, lhs, operation, rhs * 10 + digit - ?0)
  end

  defp calculate([digit | tail], lhs, operation, rhs) do
    calculate(tail, lhs * 10 + digit - ?0, operation, rhs)
  end
end
