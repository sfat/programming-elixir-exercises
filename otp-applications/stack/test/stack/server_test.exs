defmodule Stack.ServerTest do
  use ExUnit.Case

  alias Stack.Server
  
  test "should retrieve one item from stack" do
    assert Server.pop() == 3
  end
  
  test "should add number at the top of the stack" do
    Server.push(100)
    
    assert Server.pop() == 100
  end
end