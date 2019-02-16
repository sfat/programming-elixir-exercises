defmodule TestStats0 do
  use ExUnit.Case
  
  describe "Stats on list of ints" do
    
    setup do
      [
        list: [1, 3, 5, 7, 9, 11],
        sum: 36,
        count: 6
      ]
    end
    
    test "calculates sum" do
      assert Stats.sum(fixture.list) == fixture.sum
    end
    
    test "calculates count" do
      assert Stats.count(fixture.list) == fixture.count
    end
    
    test "calculates average" do
      assert Stats.average(fixture.list) == fixture.sum / fixture.count
    end
  end
end