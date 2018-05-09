defmodule FuckFlake do

  use Application
  require Logger

  @server FuckFlake.Generator.Server

  def start(_type, _args) do

    Logger.info("Starting fuckflake")

    children = [
      {@server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: FuckFlake.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end

  # clients
  def fuck() do
    FuckFlake.Generator.Server.fuck()
  end

  def fuck58() do
    FuckFlake.Generator.Server.fuck58()
  end

  # helpers
  def to_sing(num) do
    num - 9_223_372_036_854_775_808
  end

  def to_unsing(num) do
    num + 9_223_372_036_854_775_808
  end

  def int_to_b58(int) do
    int
    |> to_unsing()
    |> :base58.integer_to_base58
  end

  def uint_to_b58(uint) do
    uint
    |> :base58.integer_to_base58
  end

  def uid_to_b58(uid) do int_to_b58(uid) end

  def b58_to_int(b58) do
    to_charlist(b58)
    |> :base58.base58_to_integer()
    |> to_sing()
  end

  def b58_to_uid(b58) do b58_to_int(b58) end

  def b58_to_uint(b58) do
    to_charlist(b58)
    |> :base58.base58_to_integer()
  end

  def config(name) do
    Application.get_env :fuck_lake, name
  end

end
