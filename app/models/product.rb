class Product < ApplicationRecord
  has_many :subscribers, dependent: :destroy
  has_one_attached :featured_image
  has_rich_text :description
  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :category, inclusion: { in: %w[seating tables storage decor other], allow_blank: true }

  after_update_commit :notify_subscribers, if: :back_in_stock?

  include Notifications
end
