class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    cart = session[:cart] ||= []

    existing_item = cart.find { |item| item["product_id"] == product.id }

    if existing_item
      existing_item["quantity"] += quantity
    else
      cart << { "product_id" => product.id, "quantity" => quantity }
    end

    session[:cart] = cart
    redirect_to cart_path, notice: "#{product.name} added to cart!"
  end

  def destroy
    product_id = params[:id].to_i
    cart = session[:cart] || []

    cart.reject! { |item| item['product_id'] == product_id }

    session[:cart] = cart
    redirect_to cart_path, notice: "Item removed from cart."
  end
end
