defmodule ProductStudioDemoWeb.ProductController do
  use ProductStudioDemoWeb, :controller

  alias ProductStudioDemo.Products
  alias ProductStudioDemo.Products.Product
  alias ProductStudioDemoWeb.Validator.JsonValidator

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  def new(conn, _params) do
    changeset = Products.change_product(%Product{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    map = product_params
    price = IO.inspect(String.to_float(map["price"]))
    stock = IO.inspect(String.to_integer(map["stock"]))
    description = IO.inspect(map["description"])
    name = IO.inspect(map["name"])
    IO.inspect(Map.fetch(map, "price"))

    product = %{"description" => description, "name" => name, "price" => price, "stock" => stock}

    case ExJsonSchema.Validator.validate(JsonValidator.schema(), product) do
      :ok ->
        case Products.create_product(product_params) do
          {:ok, product} ->
            conn
            |> put_flash(:info, "Product created successfully.")
            |> redirect(to: ~p"/products/#{product}")

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, :new, changeset: changeset)
        end

        # {:error, %Ecto.Changeset{} = changeset} ->
        #   render(conn, :new, changeset: changeset)

      {:error, _errors} ->
        conn
        |> put_flash(:error, "Error! You have inserted the wrong information")
        |> redirect(to: ~p"/products")
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, :show, product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    changeset = Products.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    case Products.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end
end
