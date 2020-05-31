defmodule Bls do
  @moduledoc """
  Wrapper around the BLS 12-381 eliptic curve contruction and signature scheme in Rust by SigmaPrime.
  """

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def new_kp(), do: :erlang.nif_error(:nif_not_loaded)
  def sign(_msg, _d, _sk), do: :erlang.nif_error(:nif_not_loaded)
  def verify(_sig, _msg, _d, _pk), do: :erlang.nif_error(:nif_not_loaded)
  def asig_verify(_asig, _msg, _d, _agpk), do: :erlang.nif_error(:nif_not_loaded)
  def new_sk(), do: :erlang.nif_error(:nif_not_loaded)
  def new_sk_from_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def sk_to_bytes(_pk), do: :erlang.nif_error(:nif_not_loaded)
  def pk_from_sk(_sk), do: :erlang.nif_error(:nif_not_loaded)
  def pk_to_bytes(_pk), do: :erlang.nif_error(:nif_not_loaded)
  def asig_new(), do: :erlang.nif_error(:nif_not_loaded)
  def asig_add(_asig, _sig), do: :erlang.nif_error(:nif_not_loaded)
  def asig_add_aggregate(_asig1, _asig2), do: :erlang.nif_error(:nif_not_loaded)
  def asig_to_bytes(_asig), do: :erlang.nif_error(:nif_not_loaded)
  def agpk_new(), do: :erlang.nif_error(:nif_not_loaded)
  def agpk_to_bytes(_agpk), do: :erlang.nif_error(:nif_not_loaded)
  def agpk_add(_agpk, _pk), do: :erlang.nif_error(:nif_not_loaded)
  def agpk_from_bytes(_bytes), do: :erlang.nif_error(:nif_not_loaded)
  def agpk_add_aggregate(_agpk1, _agpk2), do: :erlang.nif_error(:nif_not_loaded)

  defmodule Signature do
    @moduledoc """
    Module for signing and verifying BLS signatures.
    """

    defmodule Aggregate do
      @moduledoc """
      Functions for aggregating signatures and verifying them.
      """
      def new() do
        Bls.asig_new()
      end

      def to_bytes(asig) do
        Bls.asig_to_bytes(asig)
      end

      def add(asig, sig) do
        Bls.asig_add(asig, sig)
      end

      def add_aggregate(asig1, asig2) do
        Bls.asig_add_aggregate(asig1, asig2)
      end

      def verify(asig, msg, d, agpk) do
        Bls.asig_verify(asig, msg, d, agpk)
      end
    end

    def sign(msg, d, sk) when is_atom(msg), do: msg |> Atom.to_charlist() |> Bls.sign(d, sk)
    def sign(msg, d, sk) when is_binary(msg), do: msg |> :binary.bin_to_list() |> Bls.sign(d, sk)

    def sign(msg, d, sk) when is_bitstring(msg),
      do: msg |> :binary.bin_to_list() |> Bls.sign(d, sk)

    def sign(msg, d, sk) when is_number(msg), do: msg |> Enum.into([] |> Bls.sign(d, sk))
    def sign(msg, d, sk), do: Bls.sign(msg, d, sk)

    def verify(sig, msg, d, pk) when is_atom(msg) do
      msg = :binary.bin_to_list(msg)
      Bls.verify(sig, msg, d, pk)
    end

    def verify(sig, msg, d, pk) when is_binary(msg) do
      msg = :binary.bin_to_list(msg)
      Bls.verify(sig, msg, d, pk)
    end

    def verify(sig, msg, d, pk) when is_bitstring(msg) do
      msg = :binary.bin_to_list(msg)
      Bls.verify(sig, msg, d, pk)
    end

    def verify(sig, msg, d, pk) when is_number(msg) do
      msg = Enum.into(msg, [])
      Bls.verify(sig, msg, d, pk)
    end

    def verify(sig, msg, d, pk), do: Bls.verify(sig, msg, d, pk)
  end

  defmodule Keys do
    @moduledoc """
    Module for generating public and secret keys in various ways.
    """
    defmodule AggregatePublicKey do
      def new() do
        Bls.agpk_new()
      end

      def add(agpk, pk) do
        Bls.agpk_add(agpk, pk)
      end

      def add_aggregate(agpk1, agpk2) do
        Bls.agpk_add_aggregate(agpk1, agpk2)
      end

      def to_bytes(agpk) do
        Bls.agpk_to_bytes(agpk)
      end

      def from_bytes(bytes) do
        Bls.agpk_from_bytes(bytes)
      end
    end

    defmodule PublicKey do
      @moduledoc """
      Lets you derive a public key from a secret key and export it.
      """
      def from_sk(sk) do
        Bls.pk_from_sk(sk)
      end

      def to_bytes(pk) do
        Bls.pk_to_bytes(pk)
      end
    end

    defmodule SecretKey do
      @moduledoc """
      Lets you create new secret key from randomness or seeded with 48 bytes and export it.
      """

      def new() do
        Bls.new_sk()
      end

      def from_bytes(bytes) when is_binary(bytes) do
        bytes |> :binary.bin_to_list() |> Bls.new_sk_from_bytes()
      end

      def from_bytes(bytes) do
        bytes |> Bls.new_sk_from_bytes()
      end

      def to_bytes(pk) do
        Bls.sk_to_bytes(pk)
      end
    end

    defmodule Keypair do
      @moduledoc """
      Module for generating a new keypair.
      """
      defstruct [:secret_key, :public_key]

      def new() do
        {sk, pk} = Bls.new_kp()
        %Keypair{secret_key: sk, public_key: pk}
      end
    end
  end

  def hello() do
    :world
  end
end
