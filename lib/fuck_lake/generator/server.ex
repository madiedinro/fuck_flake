defmodule FuckLake.Generator.Server do

  require Logger
  use GenServer

  @max_val 255
  @time_offset 1514764800000  #2018-01-01
  @node_id 1
  @name __MODULE__


  def fuck() do
    GenServer.call(@name, :fuck)
  end


  def fuck58() do
    fuck()
    |> :base58.integer_to_base58()
  end


  # Client side

  def init(args) do
    {:ok, args}
  end

  def start_link(_) do
    GenServer.start_link(@name, 0, [name: @name])
  end

  def id_int() do

    offset = :os.system_time(:milli_seconds) - @time_offset
    <<r0 :: 16, r1 :: 8>> = :crypto.strong_rand_bytes(3)
    <<number :: integer - size(64)>> = <<r0 :: 16, offset :: 40, r1 :: 8>>

    number
  end

  def id_str() do
    id_int()
    |> Integer.to_string()
  end

  def new_sid() do
    id_int()
    |> :base58.integer_to_base58()
  end

  def to_sing(num) do
    num - 9_223_372_036_854_775_808
  end

  def to_unsing(num) do
    num + 9_223_372_036_854_775_808
  end


  # with sign -9223372036854775808..+9223372036854775807
  def sid_to_uid(sid) do
    to_charlist(sid)
    |> :base58.base58_to_integer()
    |> to_sing()

  end

  def uid_to_sid(key) do
    key
    |> to_unsing()
    |> :base58.integer_to_base58
  end

  # FuckFlake
  def handle_call(:fuck, _from, state) do

    offset = :os.system_time(:milli_seconds) - @time_offset
    <<r0 :: 8>> = :crypto.strong_rand_bytes(1)

    # 0 .. 18446744073709551615
    <<uid :: integer - size(64)>> = <<r0 :: 8, state :: 8, offset :: 40, @node_id :: 8>>

    state = if state == @max_val, do: 0, else: state + 1

    {:reply, uid, state}
  end

end
