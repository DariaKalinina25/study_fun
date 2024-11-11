# frozen_string_literal: true

# SimpleCov setup
require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'

  # Exclude from coverage until logic is implemented
  add_filter 'app/jobs/'
  add_filter 'app/mailers/'
  add_filter 'app/channels/'
end

RSpec.configure do |config|
  # Output error information in documentation format
  config.formatter = :documentation

  # Adds details about the method call chain in matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Checks that methods called on the mock actually exist
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Automatically applies metadata from shared_context to all related groups and tests
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Runs tests in random order to identify dependent tests
  config.order = :random
  Kernel.srand config.seed
end
