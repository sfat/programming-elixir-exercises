defmodule Ascii do
  def validate(string) do
    # Enum.all?(string, fn c -> c >= 32 and c <= 126 end)
    validate(string, false)
  end

  def validate([], valid), do: valid
  def validate([head | _], _) when head < 32 or head > 126, do: false

  def validate([head | tail], _valid) when head >= 32 and head <= 126 do
    validate(tail, true)
  end
end
