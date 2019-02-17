defmodule SpawnMultiple do
  
  def run do
    create_process("betty")
    create_process("fred")  
  end
  
  def create_process(token) do
    process = spawn(SpawnMultiple, :greet, [self()])
    send process, token
    receive do
      response -> IO.puts(inspect(response))
    end
  end
  
  def greet(caller) do
    receive do
      token = "fred" ->
        :timer.sleep(500)
        send caller, token
      token ->
        send caller, token
    end
  end
end