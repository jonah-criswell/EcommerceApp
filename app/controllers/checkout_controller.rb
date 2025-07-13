class CheckoutController < ApplicationController
  allow_unauthenticated_access only: [:create, :success]
  def create
    cart = session[:cart] || []

    line_items = cart.map do |item|
      product = Product.find(item["product_id"])
      {
        price_data: {
          currency: 'usd',
          product_data: {
            name: product.name,
          },
          unit_amount: (product.price * 100).to_i, 
          tax_behavior: 'exclusive',
        },
        quantity: item["quantity"],
      }
    end

     # Add a flat shipping fee of $5.00 (500 cents)
    line_items << {
      price_data: {
        currency: 'usd',
        product_data: {
          name: "Flat Rate Shipping",
        },
        unit_amount: 500,
      },
      quantity: 1,
    }

    # Create a Stripe Checkout Session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      automatic_tax: {
        enabled: true
      },
      shipping_address_collection: {
        allowed_countries: ['US']
      },
      payment_intent_data: {
        description: "eCommerce Checkout",
      },

      success_url: checkout_success_url + "?success=true",
      cancel_url: cart_url + "?cancel=true"
    )
    redirect_to session.url, allow_other_host: true
  end
  
  def success
    # Reduce inventory for all items in the cart
    cart = session[:cart] || []
    cart.each do |item|
      product = Product.find_by(id: item["product_id"])
      if product
        new_inventory = product.inventory_count - item["quantity"]
        product.update(inventory_count: [new_inventory, 0].max)
      end
    end
    
    session[:cart] = [] 
    flash[:notice] = "Thank you for your purchase!"
    redirect_to root_path
  end
end
