defmodule IslandsEngine.GameSupervisor do
  use DynamicSupervisor
  alias IslandsEngine.Game


  def start_link(_option), do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def start_game(_option) do
    spec = {Game, {}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def init(:ok),  do: DynamicSupervisor.init(strategy: :one_for_one)

end
