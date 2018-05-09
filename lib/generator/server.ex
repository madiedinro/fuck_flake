defmodule FuckFlake.Generator.Server do

  require Logger
  use GenServer

  @max_val 255
  @time_offset 1514764800000  #2018-01-01
  @name __MODULE__


  # Client side
  def fuck() do
    GenServer.call(FuckFlake.Generator.Server, :fuck)
  end

  def fuck58() do
    fuck()
    |> :base58.integer_to_base58()
  end

  # server side
  def init(args) do
    {:ok, args}
  end

  def start_link(_) do
    GenServer.start_link(@name, 0, [name: @name])
  end

  # FuckFlake
  def handle_call(:fuck, _from, state) do

    offset = :os.system_time(:milli_seconds) - @time_offset
    <<r0 :: 8>> = :crypto.strong_rand_bytes(1)

    # 0 .. 18446744073709551615
    <<uid :: integer - size(64)>> = <<r0 :: 8, state :: 8, offset :: 40, config(:node_id) :: 8>>

    state = if state == @max_val, do: 0, else: state + 1

    {:reply, uid, state}
  end

  def config(name) do
    Application.get_env :fuck_flake, name
  end

end
