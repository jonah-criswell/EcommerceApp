class CartsController < ApplicationController
  allow_unauthenticated_access only: [:show, :clear]
  def show
    session[:cart] ||= []

    @cart_items = session[:cart].map do |item|
      product = Product.find_by(id: item["product_id"])
      next unless product  # skip if product not found

      {
        product: product,
        quantity: item["quantity"].to_i
      }
    end.compact  # remove any nils from skipped products

    @total_price = @cart_items.sum { |item| item[:product].price * item[:quantity] }
  end

  def clear
    session[:cart] = []
    redirect_to cart_path, notice: "Cart cleared."
  end
end
