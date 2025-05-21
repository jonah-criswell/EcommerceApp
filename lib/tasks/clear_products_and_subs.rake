namespace :db do
  desc "Delete all subscribers, products, and associated rich text safely"
  task clear_products_and_subscribers: :environment do
    puts "Deleting all product descriptions..."
    ActionText::RichText.where(record_type: "Product").delete_all

    puts "Deleting all subscribers..."
    Subscriber.delete_all

    puts "Deleting all products..."
    Product.delete_all

    puts "Done! All subscribers, products, and product descriptions deleted."
  end
end