# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'factory_bot_rails'

# Checks that all migrations are applied in the test database
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Includes the create and build methods without the FactoryBot prefix
  config.include FactoryBot::Syntax::Methods

  # Enables transactions to automatically roll back changes after each test
  config.use_transactional_fixtures = true

  # Defines the test type
  config.infer_spec_type_from_file_location!

  # Hides internal Rails methods in errors for easier reading
  config.filter_rails_from_backtrace!
end
