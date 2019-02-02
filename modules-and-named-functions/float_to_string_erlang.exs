defmodule ErlangFloatToString do
    def convert(number) do
        :io_lib.format("Number formatted: ~.2f", [number])
    end
end
