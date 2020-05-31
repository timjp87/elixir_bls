defmodule Bls do
  @moduledoc """
  Wrapper around the BLS 12-381 eliptic curve contruction and signature scheme in Rust by SigmaPrime.
  """
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    Logger.info("Initializing BLS.")
    {:ok, bytes} = File.read("bls_c.wasm")
    {:ok, pid} = Wasmex.start_link(bytes)
    Wasmex.call_function(pid, "blsInit", [5, 246])
    Wasmex.call_function(pid, "blsSetETHmode", [3])
    {:ok, pid}
  end
end
