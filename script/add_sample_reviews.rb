# Run with: bin/rails runner script/add_sample_reviews.rb

# Create multiple fake users with realistic names
fake_users = [
  { email: "sarah.johnson@example.com", name: "Sarah Johnson" },
  { email: "michael.chen@example.com", name: "Michael Chen" },
  { email: "emily.rodriguez@example.com", name: "Emily Rodriguez" },
  { email: "david.thompson@example.com", name: "David Thompson" },
  { email: "jessica.williams@example.com", name: "Jessica Williams" },
  { email: "alex.kumar@example.com", name: "Alex Kumar" },
  { email: "rachel.garcia@example.com", name: "Rachel Garcia" },
  { email: "james.anderson@example.com", name: "James Anderson" },
  { email: "lisa.patel@example.com", name: "Lisa Patel" },
  { email: "robert.martinez@example.com", name: "Robert Martinez" },
  { email: "amanda.lee@example.com", name: "Amanda Lee" },
  { email: "kevin.nguyen@example.com", name: "Kevin Nguyen" },
  { email: "stephanie.brown@example.com", name: "Stephanie Brown" },
  { email: "daniel.kim@example.com", name: "Daniel Kim" },
  { email: "ashley.davis@example.com", name: "Ashley Davis" }
]

# Create users
users = []
fake_users.each do |user_data|
  user = User.find_or_create_by(email_address: user_data[:email]) do |u|
    u.password = "password123"
    u.password_confirmation = "password123"
  end
  users << user
  puts "Created/found user: #{user_data[:name]}"
end

# Comprehensive review data with realistic comments
reviews_data = [
  # 5-star reviews
  { rating: 5, comment: "Absolutely stunning piece! The craftsmanship is exceptional and it's become the focal point of our dining room. Worth every penny." },
  { rating: 5, comment: "Exceeded all expectations! The quality is outstanding and it arrived perfectly packaged. Highly recommend this seller." },
  { rating: 5, comment: "Beautiful design and solid construction. This piece has transformed our space completely. Love it!" },
  { rating: 5, comment: "Perfect addition to our home. The style is exactly what we were looking for and the quality is top-notch." },
  { rating: 5, comment: "Amazing quality for the price point. This furniture piece is both functional and beautiful. Very satisfied!" },
  
  # 4-star reviews
  { rating: 4, comment: "Great product overall! The design is lovely and it's very sturdy. Minor assembly required but instructions were clear." },
  { rating: 4, comment: "Solid construction and attractive design. Very happy with this purchase. Would definitely recommend." },
  { rating: 4, comment: "Nice piece of furniture. Good quality materials and the finish is beautiful. Shipping was a bit slow but worth the wait." },
  { rating: 4, comment: "Well-made and stylish. Fits perfectly in our space. The only minor issue was a small scratch that was easily fixed." },
  { rating: 4, comment: "Good value for money. The piece looks great and functions well. Assembly was straightforward." },
  { rating: 4, comment: "Lovely design and good quality. Very satisfied with this purchase. Would buy from this seller again." },
  { rating: 4, comment: "Excellent craftsmanship and beautiful finish. The piece arrived in perfect condition. Highly recommend!" },
  
  # 3-star reviews
  { rating: 3, comment: "Decent product but shipping took longer than expected. The quality is okay for the price, but not exceptional." },
  { rating: 3, comment: "Good overall, but the assembly instructions could have been clearer. The piece looks nice once assembled." },
  { rating: 3, comment: "Average quality. It serves its purpose but I expected a bit more for the price. Delivery was on time." },
  { rating: 3, comment: "The design is nice but the finish could be better. It's functional and looks good from a distance." },
  
  # Mixed reviews with different tones
  { rating: 5, comment: "This is exactly what we needed! The quality is incredible and it's so much better than what we saw in stores." },
  { rating: 4, comment: "Very pleased with this purchase. The piece is well-constructed and the design is timeless." },
  { rating: 5, comment: "Outstanding quality and beautiful design. This has become our favorite piece of furniture. Thank you!" },
  { rating: 4, comment: "Great addition to our home. The craftsmanship is evident and it's very comfortable to use." },
  { rating: 5, comment: "Absolutely love it! The attention to detail is remarkable and it's perfect for our space." },
  { rating: 4, comment: "Solid, well-made furniture. The design is classic and it should last for years. Very happy!" },
  { rating: 5, comment: "Exceptional quality and beautiful finish. This piece exceeded our expectations in every way." },
  { rating: 4, comment: "Nice design and good construction. The piece arrived safely and looks great in our home." },
  { rating: 5, comment: "Perfect! The quality is outstanding and the design is exactly what we were looking for." },
  { rating: 4, comment: "Very satisfied with this purchase. Good quality materials and the finish is beautiful." },
  { rating: 5, comment: "Amazing piece of furniture! The craftsmanship is top-notch and it's become the highlight of our room." }
]

# Add multiple reviews per product with different users
Product.all.each do |product|
  # Add 2-4 reviews per product
  num_reviews = rand(2..4)
  
  num_reviews.times do
    # Skip if this user already reviewed this product
    available_users = users.reject { |user| product.reviews.exists?(user: user) }
    next if available_users.empty?
    
    user = available_users.sample
    review_data = reviews_data.sample
    
    product.reviews.create!(
      user: user,
      rating: review_data[:rating],
      comment: review_data[:comment]
    )
    puts "Added #{review_data[:rating]}-star review to #{product.name} by #{user.email_address.split('@').first}"
  end
end

puts "\nSample reviews added successfully!"
puts "Total reviews created: #{Review.count}"
puts "Average rating across all products: #{Review.average(:rating)&.round(1) || 0}" 