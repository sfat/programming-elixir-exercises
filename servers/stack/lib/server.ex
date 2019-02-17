defmodule Stack.Server do
  use GenServer
  
  #####
  # External API
  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: __MODULE__)
  end
  
  def pop do
    GenServer.call(__MODULE__, :pop)
  end
  
  def push(number) do
    GenServer.cast(__MODULE__, {:push, number})
  end
  
  #####
  # GenServer implementation
  
  def init(list) do
    {:ok, list}
  end
  
  def handle_call(:pop, _from, []) do
    {:stop, "no more items", nil}
  end
  
  def handle_call(:pop, _from, [current | tail]) do
    {:reply, current, tail}
  end
  
  def handle_cast({:push, number}, list) do
    {:noreply, [number | list]}
  end
  
  def terminate(reason, _state) do
    {:stop, reason, nil}
  end
end