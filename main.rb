require 'rubygems'
require 'bundler'
Bundler.setup
require 'dotenv'
require 'json'
require 'pry'
require 'rack-flash' #not used so far
require 'rest-client'
require 'sinatra'
require 'sinatra/base'
require 'uri'


set :root, File.dirname(__FILE__)

Dotenv.load

configure :development do
  require 'better_errors' if development?
  require 'sinatra/reloader'
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  erb :form
end

post '/' do
  cap_title = params[:title].capitalize
  @title = params[:title]

  html = "https://data.cityofboston.gov/resource/ntv7-hwjm.json?$where=title like '%#{cap_title}%'&$limit=25000&$select=avg(total_earnings)"
  encoded_url = URI.encode html

  api_result = RestClient.get encoded_url
  result_array = JSON.parse api_result
  result = result_array.reduce Hash.new, :merge

  erb :index, :locals => {results: result['avg_total_earnings'].to_f.round(2)}
end

get '/dataset'do
  erb :dataset
end

# Easy environment check from browser
# get '/environment' do
#   if development?
#     "development"
#   elsif production?
#     "production"
#   elsif test?
#     "test"
#   else
#     "Who knows what environment you're in!"
#   end
# end

not_found do
  halt 404, 'page not found'
end
