defmodule Sequence.Stash do
  use GenServer
  
  defmodule State do
    defstruct(current_number: 0, delta: 1)
  end
  
  @me __MODULE__
  
  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: @me)
  end
  
  def get() do
    GenServer.call(@me, {:get})
  end
  
  def update(state) do
    GenServer.cast(@me, {:update, state})
  end
  
  # Server implementation
  
  def init(initial_state) do
    {:ok, initial_state}
  end
  
  def handle_call({:get}, _from, state) do
    {:reply, state, state}
  end
  
  def handle_cast({:update, state}, _current_numbet) do
    {:noreply, state}
  end
end