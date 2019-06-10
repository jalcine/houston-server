defmodule Houston.Accounts.SessionTest do
  use Houston.DataCase

  alias Houston.Accounts.Session

  describe "expired?/1" do
    test "returns true for a session that expired in the past" do
      assert Session.expired?(%Session{
               expires_at: DateTime.utc_now()
             })
    end

    test "returns false for a session expiring in the future" do
      refute Session.expired?(%Session{
               expires_at: DateTime.utc_now() |> DateTime.add(6000, :second)
             })
    end
  end

  describe "generate_token/1" do
    test "a token gets generated for a new changeset" do
      changeset = Session.changeset(%Session{}, %{})
      token = Changeset.get_field(changeset, :token)
      assert String.length(token) == 64
    end

    test "token does not get generated if already set" do
      session = AccountsFactory.build(:session)
      changeset = Session.changeset(session, %{})
      assert session.token == Changeset.get_field(changeset, :token)
    end
  end

  describe "generate_expires_at/1" do
    @one_month_in_seconds 60 * 60 * 24 * 7 * 4

    test "a reasonable expires_at gets generated if it doesn't exist" do
      changeset = Session.changeset(%Session{}, %{})
      expires_at = Changeset.get_field(changeset, :expires_at)
      one_month_from_now = DateTime.add(DateTime.utc_now(), @one_month_in_seconds, :second)

      assert DateTime.compare(DateTime.utc_now(), expires_at) == :lt
      assert DateTime.compare(one_month_from_now, expires_at) == :gt
    end

    test "expires_at does not get generated if already set" do
      session = AccountsFactory.build(:session)
      changeset = Session.changeset(session, %{})
      assert session.expires_at == Changeset.get_field(changeset, :expires_at)
    end
  end
end
