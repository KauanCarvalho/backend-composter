# frozen_string_literal: true

module DatabaseCleanerConfig
  def self.configure(config)
    config.before(:suite) do
      DatabaseCleaner.start
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean
    end

    config.after(:each) { DatabaseCleaner.clean }
    config.after(:suite) { DatabaseCleaner.clean }
  end
end
