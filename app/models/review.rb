class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, length: { maximum: 1000 }
  validates :user_id, uniqueness: { scope: :product_id, message: "You have already reviewed this product" }

  scope :recent, -> { order(created_at: :desc) }
  scope :with_comment, -> { where.not(comment: [nil, ""]) }

  def stars
    "★" * rating + "☆" * (5 - rating)
  end

  def display_name
    user.email_address.split('@').first
  end
end
