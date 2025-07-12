# Run with: bin/rails runner script/update_product_categories.rb

Product.find_each do |product|
  name = product.name
  category = case name
  when /Chair|Bench/
    "seating"
  when /Table|Desk/
    "tables"
  when /Bookshelf|Stand|Sideboard|Dresser|Rack|Shelf/
    "storage"
  when /Lamp|Mirror|Plant Stand/
    "decor"
  else
    "other"
  end
  product.update!(category: category)
  puts "Updated '#{product.name}' to category '#{category}'"
end

puts "All products updated with categories!" 