class Subscriber < ApplicationRecord
  belongs_to :product
  belongs_to :user
  generates_token_for :unsubscribe
  
  validates :user_id, uniqueness: { scope: :product_id, message: "is already subscribed to this product" }
end
