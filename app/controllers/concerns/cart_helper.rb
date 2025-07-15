module CartHelper
   def total_price(cart)
     cart_items = session[:cart].map do |item|
       product = Product.find_by(id: item["product_id"])
       next unless product  # skip if product not found

       {
         product: product,
         quantity: item["quantity"].to_i
       }
     end.compact
     cart_items.sum { |item| item[:product].price * item[:quantity] }
   end
end