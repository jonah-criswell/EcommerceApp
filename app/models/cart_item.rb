class CartItem < ApplicationRecord
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :less_than_inventory

  def less_than_inventory
    return unless product && quantity.present?

    existing_quantity = CartItem.where(product_id: product_id).where.not(id: id).sum(:quantity)
    total_quantity = existing_quantity + quantity
    
    if total_quantity > product.inventory_count
      errors.add(:quantity, "Not enough inventory for #{product.name}. Available: #{product.inventory_count}, Requested: #{total_quantity}.")
    end
  end
end
