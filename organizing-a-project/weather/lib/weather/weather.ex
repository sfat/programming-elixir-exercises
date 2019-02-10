defmodule Weather do
  
  import SweetXml
  
  @weather_url Application.get_env(:weather, :weather_url)
  
  def main do
    fetch_weather_data()
    |> pretty_print()
  end
  
  def fetch_weather_data do
    HTTPoison.get(@weather_url)
    |> handle_response
    |> decode_response
  end
  
  defp handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_errors(),
      body |> xmap(
        current_observation: [
          ~x[//current_observation],
          location: ~x[./location/text()]s,
          station_id: ~x[./station_id/text()]s,
          latitude: ~x[./latitude/text()]f,
          longitude: ~x[./longitude/text()]f,
          temp_f: ~x[./temp_f/text()]f,
          temp_c: ~x[./temp_c/text()]f,
          weather: ~x[./weather/text()]s,
          wind_string: ~x[./wind_string/text()]s
        ])
    }
  end
  
  defp check_for_errors(200), do: :ok
  defp check_for_errors(_), do: :error
  
  defp decode_response({_, %{current_observation: weather_data}}), do: weather_data
  defp decode_response({:error, error}) do
    IO.puts("Error fetching #{@weather_url}")
    System.halt(2)
  end
  
  defp pretty_print(weather_data) do
    IO.puts """
    Weather at: #{weather_data.location}
    Temperature: #{weather_data.temp_c}C
    Weather: #{weather_data.weather}
    """
  end
end
