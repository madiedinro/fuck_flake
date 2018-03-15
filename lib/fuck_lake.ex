defmodule FuckLake do

  use Application
  require Logger

  @server FuckLake.Generator.Server

  def start(_type, _args) do

    Logger.info("Starting fucklake")

    children = [
      {@server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: FuckLake.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end

  # clients
  def fuck() do
    FuckLake.Generator.Server.fuck()
  end

  def fuck58() do
    FuckLake.Generator.Server.fuck58()
  end

  # helpers
  def to_sing(num) do
    num - 9_223_372_036_854_775_808
  end

  def to_unsing(num) do
    num + 9_223_372_036_854_775_808
  end

  def uid_to_b58(uid) do
    uid
    |> to_unsing()
    |> :base58.integer_to_base58
  end

  # with sign -9223372036854775808..+9223372036854775807
  def b58_to_uid(b58) do
    to_charlist(b58)
    |> :base58.base58_to_integer()
    |> to_sing()
  end

  def config(name) do
    Application.get_env :fuck_lake, name
  end

end
