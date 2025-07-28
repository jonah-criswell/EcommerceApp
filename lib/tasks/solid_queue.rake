namespace :solid_queue do
  desc "Set up Solid Queue database schema"
  task setup: :environment do
    puts "Setting up Solid Queue database schema..."
    
    # Check if queue database is configured
    unless ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).any? { |config| config.name == "queue" }
      puts "Queue database not configured for #{Rails.env} environment. Skipping..."
      next
    end
    
    # Connect to the queue database
    ActiveRecord::Base.establish_connection(:queue)
    
    # Load the queue schema
    load Rails.root.join("db", "queue_schema.rb")
    
    puts "Solid Queue database schema setup complete!"
  end
end 