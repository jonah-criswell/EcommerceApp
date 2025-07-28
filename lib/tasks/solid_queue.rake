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

namespace :solid_cache do
  desc "Set up Solid Cache database schema"
  task setup: :environment do
    puts "Setting up Solid Cache database schema..."
    
    # Check if cache database is configured
    unless ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).any? { |config| config.name == "cache" }
      puts "Cache database not configured for #{Rails.env} environment. Skipping..."
      next
    end
    
    # Connect to the cache database
    ActiveRecord::Base.establish_connection(:cache)
    
    # Load the cache schema
    load Rails.root.join("db", "cache_schema.rb")
    
    puts "Solid Cache database schema setup complete!"
  end
end

namespace :solid do
  desc "Set up both Solid Queue and Solid Cache database schemas"
  task setup: :environment do
    puts "Setting up Solid Queue and Solid Cache database schemas..."
    
    Rake::Task["solid_queue:setup"].invoke
    Rake::Task["solid_cache:setup"].invoke
    
    puts "All Solid database schemas setup complete!"
  end
end 