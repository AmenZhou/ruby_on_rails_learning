#recursion
defmodule Count do
  def countdown(from) when from > 0 do
    IO.inspect(from)
    countdown(from-1)
  end

  def countdown(from) do
    IO.puts("blastoff!")
  end
end