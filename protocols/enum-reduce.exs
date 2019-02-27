defmodule MyEnum do
  def each(enumerable, fun) do
    reducer = fn(elem, _acc) ->
      fun.(elem)
      {:cont, nil}
    end
    enumerable
    |> Enumerable.reduce({:cont, nil}, reducer)
  end
  
  def filter(enumerable, fun) do
    reducer = fn(elem, acc) ->
      case fun.(elem) do
        true -> {:cont, [elem | acc]}
        false -> {:cont, acc}
      end
    end
    
    {:done, result} = 
      enumerable
      |> Enumerable.reduce({:cont, nil}, reducer)
      
    result
    |> Enum.reverse
  end
  
  def map(enumerable, fun) do
    reducer = fn(elem, acc) ->
      {:cont, [fun.(elem) | acc]}
    end
    
    {:done, result} = 
      enumerable
      |> Enumerable.reduce({:cont, nil}, reducer)
      
    result
    |> Enum.reverse
  end
end