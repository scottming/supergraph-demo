defmodule InventoryWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  @delivery [
    %{id: "apollo-federation", estimated_delivery: "6/25/2021", fastest_delivery: "6/24/2021"},
    %{id: "apollo-studio", estimated_delivery: "6/25/2021", fastest_delivery: "6/24/2021"}
  ]

  query do
    field(:deliveries, list_of(:delivery_estimates), resolve: fn _, _ -> {:ok, @delivery} end)
  end

  object :product do
    extends()
    key_fields("id")

    field(:id, non_null(:id), do: external())

    field(:dimensions, :product_dimension, do: external())

    field :delivery, :delivery_estimates do
      requires_fields("dimensions { size weight }")
      arg(:zip, :string)

      resolve(fn product, _args, _ ->
        {:ok,
         @delivery
         |> Enum.find(&(&1.id == product.id))}
      end)
    end
  end

  object :product_dimension do
    field(:size, :string)
    field(:weight, :float)
  end

  object :delivery_estimates do
    field(:estimated_delivery, :string)
    field(:fastest_delivery, :string)
  end
end
