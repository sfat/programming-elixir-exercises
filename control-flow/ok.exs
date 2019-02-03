defmodule Ok do
  def ok!(content) do
    case content do
      {:ok, data} ->
        data

      {problem, data} ->
        raise "Invalid data for #{data}"
    end
  end
end
