defmodule My do
  defmacro unless(condition, clause) do
    quote do
      if not unquote(condition) do
        unquote(clause)
      end
    end
  end
end

defmodule Test do
  require My
  def myunless do
    a = false
    My.unless a === true do
      IO.puts "Condition is not satistifed. This should be executed"
    end
  end
end