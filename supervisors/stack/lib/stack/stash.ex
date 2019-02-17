defmodule Stack.Stash do
  use GenServer
  
  @me __MODULE__
  
  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: @me)
  end
  
  def get() do
    GenServer.call(@me, {:get})
  end
  
  def update(list) do
    GenServer.cast(@me, {:update, list})
  end
  
  # Server implementation
  
  def init(list) do
    {:ok, list}
  end
  
  def handle_call({:get}, _from, list) do
    {:reply, list, list}
  end
  
  def handle_cast({:update, new_list}, _current_numbet) do
    {:noreply, new_list}
  end
end