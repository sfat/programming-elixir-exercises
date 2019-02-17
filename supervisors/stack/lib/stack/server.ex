defmodule Stack.Server do
  use GenServer
  
  #####
  # External API
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
  
  def pop do
    GenServer.call(__MODULE__, :pop)
  end
  
  def push(number) do
    GenServer.cast(__MODULE__, {:push, number})
  end
  
  #####
  # GenServer implementation
  
  def init(_) do
    {:ok, Stack.Stash.get()}
  end
  
  def handle_call(:pop, _from, []) do
    {:stop, "no more items", nil}
  end
  
  def handle_call(:pop, _from, [current | tail]) do
    {:reply, current, tail}
  end
  
  def handle_cast({:push, number}, list) when is_integer(number) do
    {:noreply, [number | list]}
  end
  
  def terminate(_reason, list) do
    Stack.Stash.update(list)
  end
end