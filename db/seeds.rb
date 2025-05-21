require 'open-uri'
require 'erb'
require 'ostruct'

50.times do
  product_name = Faker::Commerce.product_name

  product = Product.create!(
    name: product_name,
    price: Faker::Commerce.price(range: 5..100.0, as_string: false),
    inventory_count: rand(1..50),
  )
  #fetching image from Unsplash
  begin
    photo = Unsplash::Photo.search(product_name).first
    if photo
      image_url = photo.urls["small"]
      product.featured_image.attach(io: URI.open(image_url), filename: "#{product_name}.jpg", content_type: "image/jpg")
    end
  rescue StandardError => e
    puts "Error fetching image for #{product_name}: #{e.message}"
  end

  # Set a description for the product
    product.description = "Description for #{product_name}"
    product.save!
end

Faker::UniqueGenerator.clear