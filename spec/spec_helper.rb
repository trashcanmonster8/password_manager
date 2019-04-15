# frozen_string_literal: true

file_name = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(file_name) unless $LOAD_PATH.include?(file_name)

require 'bundler/setup'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
