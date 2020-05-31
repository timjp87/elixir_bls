defmodule Bls.Keys do
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
