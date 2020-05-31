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
    {:ok, bytes } = File.read("bls_c.wasm")
    {:ok, instance } = Wasmex.start_link(bytes)
    {:ok, instance }
  end
end
