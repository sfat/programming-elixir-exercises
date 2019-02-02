defmodule WeatherHistory do

    def for_location_27([]), do: []
    def for_location_27([ [time, 27, temp, rain] | tail ]) do
        [ [time, 27, temp, rain] | for_location_27(tail) ]
    end
    def for_location_27([ _ | tail]), do: for_location_27(tail)

    def test_data do
        [
            [1366225622, 26, 15, 0.125],
            [1366225622, 27, 15, 0.45],
            [1366225622, 28, 21, 0.25],
            [1366225622, 26, 19, 0.081],
            [1366225622, 27, 17, 0.468]
        ]
    end
end
