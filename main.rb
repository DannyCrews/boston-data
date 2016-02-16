require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require 'pry'
require 'rest-client'
require 'rack-flash'
require 'better_errors'
require 'dotenv'

Dotenv.load

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  erb :form
end

# get '/form' do
#   erb :form
# end

post '/form' do
  total = 0
  count = 0

  @title = params[:title]
  api_result = RestClient.get URI.escape("https://data.cityofboston.gov/resource/ntv7-hwjm.json?$limit=25000&$where=position_title like '%25ASSISTANT%25'")
  result_hash = JSON.parse(api_result)

  result_hash.each do |result|
    total += result['total_earnings'].to_f.round(3)
    count += 1
  end
  average = (total/count).round(2)
  erb :index, :locals => {results: average}
end

get '/dataset'do
  erb :dataset
end

not_found do
  halt 404, 'page not found'
end
