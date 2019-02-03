defmodule MyList do
    def span(from, to) when from > to and is_number(from) and is_number(to), do: []
    def span(from, to) when from <= to and is_number(from) and is_number(to), do: [from | span(from + 1, to)]
end
