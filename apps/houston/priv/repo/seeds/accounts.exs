alias Houston.AccountsFactory

AccountsFactory.insert(:user, %{
  username: "admin",
  email: "admin@elementary.io",
  password: "password"
})
