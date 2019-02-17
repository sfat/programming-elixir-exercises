defmodule MultipleProcesses do
  import :timer, only: [sleep: 1]
  
  def sad_function(pid) do
    send pid, { :ok, "Hello from child"}
    # raise("fail")
    exit(:boom)
  end
  
  def run do
    # Process.flag(:trap_exit, true)
    spawn_monitor(MultipleProcesses, :sad_function, [self()])
    sleep 500
    receive do
      msg ->
        IO.puts "Message received: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

MultipleProcesses.run