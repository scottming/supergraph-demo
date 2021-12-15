defmodule UsersWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  @users [
    %{
      email: "support@apollographql.com",
      name: "Apollo Studio Support",
      total_products_created: 4,
      __typename: "User"
    }
  ]

  query do
    extends()
  end

  object :user do
    key_fields("email")
    field(:email, non_null(:id))
    field(:name, :string)
    field(:total_products_created, :integer)

    field :_resolve_reference, :user do
      resolve(fn _, %{email: email}, _ -> {:ok, @users |> Enum.find(&(&1.email == email))} end)
    end
  end
end

