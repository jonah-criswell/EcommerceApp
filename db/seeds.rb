require 'open-uri'
require 'erb'
require 'ostruct'
require "dotenv/load"

1.times do
  product_name = Faker::Commerce.product_name

  product = Product.create!(
    name: product_name,
    price: Faker::Commerce.price(range: 5..100.0, as_string: false),
    inventory_count: rand(1..50),
  )

  prompt = "Given the product name '#{product_name}', suggest a short, relevant image search term for Unsplash. Keep it to 2-3, qne the search term should be descriptive and related to the product's category or use case."
  # Using OpenAI API to generate a search term
  response = OpenAIClient.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: [
        { role: "system", content: "You are a helpful assistant." },
        { role: "user", content: prompt }
      ],
      temperature: 0.7
    }
  )

  search_term = response.dig("choices", 0, "message", "content").strip
  puts "Generated search term: #{search_term}"

  #fetching image from Unsplash
  begin
    photo = Unsplash::Photo.search(search_term).first
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