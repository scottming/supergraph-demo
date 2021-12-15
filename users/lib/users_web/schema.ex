defmodule UsersWeb.Schema do
  use Absinthe.Schema

  @users [
    %{
      email: "support@apollographql.com",
      name: "Apollo Studio Support",
      total_products_created: 4,
      __typename: "User"
    }
  ]

  query do
    field(:users, list_of(:user), resolve: fn _, _ -> {:ok, @users} end)
  end

  object :user do
    field(:email, non_null(:id))
    field(:name, :string)
    field(:total_products_created, :integer)
  end
end
