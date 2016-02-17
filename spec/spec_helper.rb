
require File.join(File.dirname(__FILE__), '../main.rb')
require 'rack/test'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
  conf.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  conf.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  conf.include Rack::Test::Methods
  conf.order = "random"
end
