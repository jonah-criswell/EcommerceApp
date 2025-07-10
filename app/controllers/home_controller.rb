class HomeController < ApplicationController
  allow_unauthenticated_access only: [:index]

  def index
    @featured_products = Product.order('RANDOM()').limit(3)
  end
end
