require File.join(File.dirname(__FILE__), '../main.rb')
require 'rack/test'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.order = "random"
end
