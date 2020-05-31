defmodule Bls.Signature do
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
