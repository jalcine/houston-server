defmodule Houston.Accounts.UserTest do
  use Houston.DataCase

  alias Houston.Accounts.User

  describe "viewed_terms_of_service?/1" do
    @valid_date DateTime.from_naive!(~N[2050-01-01 00:00:00], "Etc/UTC")
    @invalid_date DateTime.from_naive!(~N[1990-01-01 00:00:00], "Etc/UTC")

    test "viewed_terms_of_service?/1 returns true if date is valid" do
      user = AccountsFactory.build(:user, terms_of_service: @valid_date)
      assert User.viewed_terms_of_service?(user)
    end

    test "viewed_terms_of_service?/1 returns false if date is invalid" do
      user = AccountsFactory.build(:user, terms_of_service: @invalid_date)
      refute User.viewed_terms_of_service?(user)
    end
  end
end
