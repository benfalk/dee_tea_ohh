# frozen_string_literal: true

require 'dee_tea_ohh'
require 'pry'
require 'factory_bot'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.include FactoryBot::Syntax::Methods

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
