class ProductsController < ApplicationController
  # Runs the `set_product` method before executing the `show`, `edit`, and `update` actions
  before_action :set_product, only: %i[ show edit update destroy]

  # Runs the `authenticate_user!` method before executing all actions except `index` and `show`
  allow_unauthenticated_access only: %i[ index show ]

  # Displays a list of all products
  def index
    @products = Product.all
    
    if params[:query].present?
      # Search products whose name matches the query (case-insensitive)
      @products = @products.where("LOWER(name) LIKE ?", "%#{params[:query].downcase}%")
    end
    
    if params[:category].present? && params[:category] != "All Categories"
      # Filter by category
      @products = @products.where(category: params[:category].downcase)
    end

    case params[:sort]
    when "price_asc"
      @products = @products.order(price: :asc)
    when "price_desc"
      @products = @products.order(price: :desc)
    when "name_asc"
      @products = @products.order(name: :asc)
    when "name_desc"
      @products = @products.order(name: :desc)
    end
  end

  # Displays a single product (retrieved by `set_product`)
  def show
    @user = current_user
  end

  # Initializes a new product instance for the form
  def new
    @product = Product.new
  end

  # Creates a new product with the submitted parameters
  # If successful, redirects to the product's show page
  # If unsuccessful, re-renders the new product form with an unprocessable entity status
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Displays the edit form for an existing product (retrieved by `set_product`)
  def edit
  end

  # Updates an existing product with the submitted parameters
  # If successful, redirects to the product's show page
  # If unsuccessful, re-renders the edit form with an unprocessable entity status
  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # Deletes a product (retrieved by `set_product`) and redirects to the products index page
  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
  # Finds the product based on the `id` parameter and assigns it to `@product`
  def set_product
    @product = Product.find(params[:id])
  end

  # Permits only these attributes for a product from the submitted parameters
  def product_params
    params.require(:product).permit(:name, :description, :featured_image, :inventory_count, :price, :category)
  end
end
