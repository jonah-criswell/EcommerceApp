namespace :db do
  namespace :schema do
    desc "Load cache database schema"
    task load_cache: :environment do
      puts "Loading cache database schema..."
      ActiveRecord::Base.establish_connection(:cache)
      load Rails.root.join('db', 'cache_schema.rb')
      puts "Cache database schema loaded successfully!"
    end

    desc "Load queue database schema"
    task load_queue: :environment do
      puts "Loading queue database schema..."
      ActiveRecord::Base.establish_connection(:queue)
      load Rails.root.join('db', 'queue_schema.rb')
      puts "Queue database schema loaded successfully!"
    end

    desc "Load cable database schema"
    task load_cable: :environment do
      puts "Loading cable database schema..."
      ActiveRecord::Base.establish_connection(:cable)
      load Rails.root.join('db', 'cable_schema.rb')
      puts "Cable database schema loaded successfully!"
    end

    desc "Load all additional database schemas (cache, queue, cable)"
    task load_all_additional: [:load_cache, :load_queue, :load_cable] do
      puts "All additional database schemas loaded successfully!"
    end
  end

  namespace :create do
    desc "Create cache database"
    task cache: :environment do
      puts "Creating cache database..."
      config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find(&:name)
      cache_config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find { |c| c.name == 'cache' }
      
      if cache_config
        ActiveRecord::Base.establish_connection(cache_config.config)
        ActiveRecord::Base.connection.create_database(cache_config.config['database'])
        puts "Cache database created successfully!"
      else
        puts "Cache database configuration not found!"
      end
    end

    desc "Create queue database"
    task queue: :environment do
      puts "Creating queue database..."
      config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find(&:name)
      queue_config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find { |c| c.name == 'queue' }
      
      if queue_config
        ActiveRecord::Base.establish_connection(queue_config.config)
        ActiveRecord::Base.connection.create_database(queue_config.config['database'])
        puts "Queue database created successfully!"
      else
        puts "Queue database configuration not found!"
      end
    end

    desc "Create cable database"
    task cable: :environment do
      puts "Creating cable database..."
      config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find(&:name)
      cable_config = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find { |c| c.name == 'cable' }
      
      if cable_config
        ActiveRecord::Base.establish_connection(cable_config.config)
        ActiveRecord::Base.connection.create_database(cable_config.config['database'])
        puts "Cable database created successfully!"
      else
        puts "Cable database configuration not found!"
      end
    end

    desc "Create all additional databases (cache, queue, cable)"
    task all_additional: [:cache, :queue, :cable] do
      puts "All additional databases created successfully!"
    end
  end

  desc "Set up all additional databases and schemas for solid gems"
  task setup_solid_gems: :environment do
    puts "Setting up additional databases for solid gems..."
    
    # Create databases
    Rake::Task['db:create:all_additional'].invoke
    
    # Load schemas
    Rake::Task['db:schema:load_all_additional'].invoke
    
    puts "Solid gems database setup complete!"
  end
end 