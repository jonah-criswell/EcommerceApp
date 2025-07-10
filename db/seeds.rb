require 'open-uri'

# Clear out old products
Product.destroy_all

# List of product ideas (contemporary, wooden, rustic-modern)
products = [
  { name: "Oakridge Dining Table", search: "modern wooden dining table" },
  { name: "Willow Lounge Chair", search: "wooden lounge chair" },
  { name: "Elmwood Coffee Table", search: "wood coffee table" },
  { name: "Birch Bookshelf", search: "wood bookshelf" },
  { name: "Cedar TV Stand", search: "wood tv stand" },
  { name: "Maple Bed Frame", search: "wooden bed frame" },
  { name: "Walnut Nightstand", search: "walnut nightstand" },
  { name: "Ash Writing Desk", search: "wood writing desk" },
  { name: "Pine Console Table", search: "pine console table" },
  { name: "Teak Sideboard", search: "teak sideboard" },
  { name: "Acacia Bench", search: "acacia wood bench" },
  { name: "Spruce Wall Shelf", search: "wood wall shelf" },
  { name: "Mahogany Dresser", search: "mahogany dresser" },
  { name: "Rustic Entryway Rack", search: "rustic entryway rack" },
  { name: "Minimalist Plant Stand", search: "wood plant stand" },
  { name: "Contemporary Floor Lamp", search: "modern floor lamp wood" },
  { name: "Scandinavian Side Table", search: "scandinavian side table" },
  { name: "Modern Wooden Mirror", search: "wooden frame mirror" }
]

def get_image_url(search_term)
  # Use a simple, reliable image service
  "https://picsum.photos/600/400?random=#{search_term.hash}"
end

products.each_with_index do |prod, index|
  price = rand(80..1200)
  description = case prod[:name]
  when /Table/
    "A beautifully crafted table made from premium wood, perfect for contemporary spaces."
  when /Chair/
    "A comfortable and stylish lounge chair with a modern wooden frame."
  when /Bookshelf/
    "A spacious bookshelf with a rustic-modern design, ideal for any living room or study."
  when /Stand/
    "A sturdy and elegant stand, blending rustic charm with modern lines."
  when /Bed/
    "A solid wood bed frame that brings warmth and style to your bedroom."
  when /Nightstand/
    "A compact nightstand with a rich wood finish, perfect for bedside essentials."
  when /Desk/
    "A minimalist writing desk with clean lines and natural wood grain."
  when /Console/
    "A versatile console table that fits entryways or living rooms alike."
  when /Sideboard/
    "A spacious sideboard with contemporary hardware and a wooden finish."
  when /Bench/
    "A durable bench crafted from acacia wood, great for dining or entryways."
  when /Shelf/
    "A floating wall shelf with a modern rustic vibe."
  when /Dresser/
    "A roomy dresser with a deep mahogany finish and modern silhouette."
  when /Rack/
    "A rustic entryway rack for coats, hats, and bags."
  when /Plant Stand/
    "A minimalist plant stand to showcase your favorite greenery."
  when /Lamp/
    "A contemporary floor lamp with a wooden base and soft lighting."
  when /Mirror/
    "A modern mirror with a wooden frame, perfect for any room."
  else
    "A unique piece of contemporary wooden furniture."
  end

  puts "\nCreating product #{index + 1}/#{products.length}: #{prod[:name]}"
  begin
    product = Product.create!(
      name: prod[:name],
      price: price,
      inventory_count: rand(5..30),
      description: description
    )
    puts "✓ Product created: #{product.name}"
  rescue => e
    puts "✗ Error creating product #{prod[:name]}: #{e.class} - #{e.message}"
    puts e.backtrace.take(5).join("\n")
    next
  end

  # Try to fetch image with multiple fallbacks
  image_url = get_image_url(prod[:search])
  begin
    puts "  Fetching image from: #{image_url}"
    file = URI.open(image_url, read_timeout: 15, open_timeout: 10)
    product.featured_image.attach(
      io: file, 
      filename: "#{prod[:name].parameterize}.jpg", 
      content_type: 'image/jpeg'
    )
    puts "  ✓ Image attached successfully for #{prod[:name]}"
  rescue => e
    puts "  ✗ Could not fetch image for #{prod[:name]}: #{e.class} - #{e.message}"
    puts e.backtrace.take(5).join("\n")
    puts "    Product created without image - you can add one manually later"
  end
end

puts "\nSeeding completed! Created #{Product.count} products."
puts "Products with images: #{Product.joins(:featured_image_attachment).count}"

if Product.joins(:featured_image_attachment).count < Product.count
  puts "\nSome products don't have images. You can:"
  puts "1. Add images manually through the admin interface"
  puts "2. Run the seeding again later when network issues are resolved"
  puts "3. Use the product management interface to upload images"
end