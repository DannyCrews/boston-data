require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require 'pry'
require 'soda'
require 'rack-flash'
require 'better_errors'
require 'dotenv'

Dotenv.load

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

client = SODA::Client.new({
  :domain => "data.cityofboston.gov",
  :app_token => ENV["ACCESS_KEY"]                                  #"nXPqaTa5IpL5WmOGwORxoWGcF"
})

get '/' do
  api_result = client.get("ntv7-hwjm.json", {"$limit" => 50000})

  output = ''
  total = 0
  count = 0

  api_result.each do |record|
    total += record.total_earnings.to_i
    count += 1
    output << "<tr><td>#{total}</td><td>#{count}<td>#{total/count}</tr>"
  end

  # output = "<tr><td>#{total}</td><td>#{count}</tr>"
  erb :index, :locals => {results: output}
end

get '/form/query/' do
  @testvar = "this is testvar"
  erb :query_result
end

get '/form/?' do
    @title = params[:title]
    erb :form
end


not_found do
  halt 404, 'page not found'
end


