class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment

      t.timestamps
    end

    add_index :reviews, [:user_id, :product_id], unique: true
    add_check_constraint :reviews, "rating >= 1 AND rating <= 5", name: "check_rating_range"
  end
end
