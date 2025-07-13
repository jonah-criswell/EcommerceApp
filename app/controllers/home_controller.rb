class HomeController < ApplicationController
  allow_unauthenticated_access only: [:index]

  def index
    @featured_products = Product.order('RANDOM()').limit(3)
    
    @featured_reviews = {}
    @featured_products.each do |product|
    
      max_rating = product.reviews.maximum(:rating)
      
      if max_rating
        top_reviews = product.reviews.where(rating: max_rating)
        @featured_reviews[product.id] = top_reviews.sample
      end
    end
  end
end
