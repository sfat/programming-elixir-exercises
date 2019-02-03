defmodule MyEnum do
  def all?(enumerable, func) do
    all_acc?(enumerable, nil, func)
  end

  defp all_acc?([], valid, _func), do: valid

  defp all_acc?([head | tail], _valid, func) do
    if func.(head) == true do
      all_acc?(tail, true, func)
    else
      all_acc?([], false, func)
    end
  end

  def each([], _func), do: []

  def each([head | tail], func) do
    [func.(head) | each(tail, func)]
  end

  def filter([], _func), do: []

  def filter([head | tail], func) do
    if func.(head) == true do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(enumerable, count) do
    split_acc(enumerable, [], count)
  end

  defp split_acc([], _split, _count), do: []

  defp split_acc([head | tail], split, count) when count > 0 do
    split_acc(tail, [head | split], count - 1)
  end

  defp split_acc(enumerable, split, count) when count == 0 do
    [split | [enumerable]]
  end
end
