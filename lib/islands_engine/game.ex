defmodule IslandsEngine.Game do
  use GenServer


  def demo_call(game) do
    GenServer.call(game, :demo_call)
  end

  def demo_cast(pid, new_value) do
    GenServer.cast(pid, {:demo_cast, new_value})
  end

  def handle_info(:first, state) do
    IO.puts "This message has been handled ny handles_info/2, matching on:first."
    {:noreply, state}
  end

  def handle_call(:demo_call, from, state) do
    IO.inspect(from)
    {:reply, state, state}
  end

  def handle_cast({:demo_cast, new_value}, state) do
    {:noreply, Map.put(state, :pinto, new_value)}
  end
end
