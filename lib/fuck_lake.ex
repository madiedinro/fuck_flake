defmodule FuckLake do

  use Application

  require Logger

  def start(_type, _args) do

    Logger.info("Starting fucklake")

    children = [
      {FuckLake.Generator.Server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: FuckLake.Supervisor
    ]

    Supervisor.start_link(children, opts)

  end

  def fuck() do
    GenServer.call(FuckLake.Generator.Server, :fuck)
  end

  def fuck58() do
    fuck()
    |> :base58.integer_to_base58()
  end


  def config(name) do
    Application.get_env :fuck_lake, name
  end

  def hello do
    :world
  end
end
