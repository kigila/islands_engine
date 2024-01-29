defmodule IslandsEngine.GameSupervisor do
  use DynamicSupervisor
  alias IslandsEngine.Game


  def start_link(init_arg), do: DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)

  @impl true
  def init(_name),  do: DynamicSupervisor.init(strategy: :one_for_one)


  def start_game(name) do
    spec = %{id: Game, start: {Game, :start_game, [name]}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def stop_game(name) do
    :ets.delete(:game_state, name)
    DynamicSupervisor.terminate_child(__MODULE__, pid_from_name(name))
  end

  defp pid_from_name(name) do
    name
    |> Game.via_tuple()
    |> GenServer.whereis()
  end

end
