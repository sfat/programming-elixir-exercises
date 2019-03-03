defmodule KinectProtocolError do
  defexception message: "Kinect protocol error",
               can_retry: false
  
  def full_message(me) do
    "Kinect failed: #{me.message}, retryable: #{me.can_retry}"
  end
end

defmodule TestDefException do
  def my_own_exception() do
    try do
      talk_to_kinect()
    rescue
      error in [KinectProtocolError] ->
        IO.puts KinectProtocolError.full_message(error)
        if error.can_retry, do: schedule_retry()
    end
  end
  
  def talk_to_kinect() do
    # simulating kinect error
    raise %KinectProtocolError{can_retry: true}
  end
  
  defp schedule_retry() do
    IO.puts "retry scheduled..."
  end
end