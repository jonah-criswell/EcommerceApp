class ChangeSubscribersToUseUserId < ActiveRecord::Migration[8.0]
  def up
    # First, clear existing subscribers since we can't map them to users
    execute "DELETE FROM subscribers"
    
    # Remove the email column and add user_id column
    remove_column :subscribers, :email, :string
    add_reference :subscribers, :user, null: false, foreign_key: true
    
    # Add a unique index to prevent duplicate subscriptions
    add_index :subscribers, [:user_id, :product_id], unique: true
  end

  def down
    # Remove the user_id column and add email column back
    remove_reference :subscribers, :user, foreign_key: true
    add_column :subscribers, :email, :string
  end
end 