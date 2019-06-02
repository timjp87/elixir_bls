defmodule BlsTest do
  use ExUnit.Case
  doctest Bls

  test "create a keypair" do
    keypair = Bls.Keys.Keypair.new()
    Map.fetch!(keypair, :public_key)
    Map.fetch!(keypair, :secret_key)
  end

  test "load secret key from bytes" do
    bytes = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      78,
      252,
      122,
      126,
      32,
      0,
      75,
      89,
      252,
      31,
      42,
      130,
      254,
      88,
      6,
      90,
      138,
      202,
      135,
      194,
      233,
      117,
      181,
      75,
      96,
      238,
      79,
      100,
      237,
      59,
      140,
      111
    ]

    {res, _sk} = Bls.Keys.SecretKey.from_bytes(bytes)
    assert res == :ok
  end

  test "sign and verify with keypair" do
    keypair = Bls.Keys.Keypair.new()
    message = 'The quick brown fox jumps over the lazy dog'
    d = 1
    sig = Bls.Signature.sign(message, d, keypair.secret_key)
    assert Bls.Signature.verify(sig, message, d, keypair.public_key)
  end

  test "verify signature that was signed with secret key initialized from bytes" do
    keypair = Bls.Keys.Keypair.new()
    message = 'The quick brown fox jumps over the lazy dog'
    d = 1
    bytes = Bls.Keys.SecretKey.to_bytes(keypair.secret_key)
    {_result, secret_key} = Bls.Keys.SecretKey.from_bytes(bytes)
    sig = Bls.Signature.sign(message, d, secret_key)
    assert Bls.Signature.verify(sig, message, d, keypair.public_key)
  end
end
