defmodule Houston.Types.OneWayEncryptedString do
  @behaviour Ecto.Type

  def type, do: :binary

  def cast(value) do
    {:ok, to_string(value)}
  end

  def dump(value) do
    {:ok, hash(value)}
  end

  def load(value) do
    {:ok, value}
  end

  def hash(value) do
    Argon2.hash_pwd_salt(value)
  end

  def same?(value, check) do
    Argon2.verify_pass(check, value)
  end
end
