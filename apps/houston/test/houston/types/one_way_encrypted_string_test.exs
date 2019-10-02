defmodule Houston.Types.OneWayEncryptedStringTest do
  use ExUnit.Case

  alias Houston.Types.OneWayEncryptedString, as: OWES

  @string "testing"

  test "dump/1 encrypts the value" do
    {:ok, hash} = OWES.dump(@string)
    assert hash != @string
  end

  test "dump/1 is not pure" do
    assert OWES.dump(@string) != OWES.dump(@string)
  end

  test "load/1 does not convert to unencrypted value" do
    {:ok, hash} = OWES.dump(@string)
    {:ok, loaded} = OWES.load(hash)
    assert loaded != @string
  end

  test "same?/2 returns true for same values" do
    {:ok, hash} = OWES.dump(@string)
    assert OWES.same?(hash, @string)
  end

  test "same?/2 returns false for different values" do
    {:ok, hash} = OWES.dump(@string)
    refute OWES.same?(hash, "nope")
  end
end
